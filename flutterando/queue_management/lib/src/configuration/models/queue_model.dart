import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/value_objects/order.dart';

class QueueModel extends QueueEntity {
  QueueModel({
    required super.id,
    required super.title,
    required super.abbr,
    required super.priority,
    required super.orders,
  });

  factory QueueModel.empty() => QueueModel(
        id: '',
        title: '',
        abbr: '',
        priority: 0,
        orders: [],
      );

  QueueModel copyWith({
    String? id,
    String? title,
    String? abbr,
    int? priority,
    List<Order>? orders,
  }) {
    return QueueModel(
      id: id ?? this.id,
      title: title ?? this.title,
      abbr: abbr ?? this.abbr,
      priority: priority ?? this.priority,
      orders: orders ?? this.orders,
    );
  }
}
