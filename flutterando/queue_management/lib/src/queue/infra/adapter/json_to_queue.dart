import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/infra/adapter/json_to_order.dart';

class JsonToQueue {
  static QueueEntity fromMap(dynamic json) {
    return QueueEntity(
      id: json['id'],
      title: json['title'],
      abbr: json['abbr'],
      priority: json['priority'],
      orders: json.containsKey('orders')
          ? (json['orders'] as List).map(JsonToOrder.fromMap).toList()
          : [],
    );
  }

  static Map<String, dynamic> toMap(QueueEntity queue) {
    return {
      'id': queue.id,
      'title': queue.title,
      'priority': queue.priority,
      'abbr': queue.abbr,
      'orders': queue.orders.map(JsonToOrder.toMap).toList(),
    };
  }
}
