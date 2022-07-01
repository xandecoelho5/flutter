import 'package:flutter_test/flutter_test.dart';
import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/value_objects/order.dart';
import 'package:queue_management/src/queue/infra/adapter/json_to_queue.dart';

void main() {
  test('deve converter um map em um objeto do tipo QueueEntity', () {
    final queue = JsonToQueue.fromMap({
      'id': 'dsfdfd',
      'title': 'title',
      'priority': 1,
      'abbr': 'sd',
      'orders': [
        {
          'id': 'dsfdfd',
          'position': 1,
          'status': 'attending',
          'timestamp': '2022-03-31 18:37:30',
        },
      ]
    });

    expect(queue, isA<QueueEntity>());
    expect(queue.title, 'title');
    expect(queue.priority, 1);
    expect(queue.orders.first.status, OrderStatus.attending);
  });

  test('deve converter QueueEntity to Map', () {
    final order = Order(
      id: 'adasdsad',
      position: 1,
      timestamp: DateTime.now(),
      status: OrderStatus.waiting,
    );

    final queue = QueueEntity(
      id: 'asdsadasd',
      title: 'title',
      abbr: 'abbr',
      priority: 1,
      orders: [order],
    );

    final map = JsonToQueue.toMap(queue);

    expect(map['id'], 'asdsadasd');
    expect(map['title'], 'title');
    expect(map['orders'][0]['status'], 'waiting');
  });
}
