import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/value_objects/order.dart';

abstract class IGenerateOrder {
  QueueEntity call(QueueEntity queue);
}

class GenerateOrder implements IGenerateOrder {
  @override
  QueueEntity call(QueueEntity queue) {
    final orders = List<Order>.from(queue.orders);

    final totalOrders = queue.orders.length;

    final order = Order(
      id: '${totalOrders + 1}'.padLeft(4, '0'),
      position: totalOrders + 1,
      timestamp: DateTime.now(),
      status: OrderStatus.waiting,
    );

    queue.orders.add(order);

    return QueueEntity(
      id: queue.id,
      title: queue.title,
      abbr: queue.abbr,
      priority: queue.priority,
      orders: orders,
    );
  }
}
