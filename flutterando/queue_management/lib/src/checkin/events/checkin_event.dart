import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/value_objects/order.dart';

abstract class CheckinEvent {}

class FetchAllQueues implements CheckinEvent {}

class PrintOrder implements CheckinEvent {
  final Order order;

  PrintOrder(this.order);
}

class GenerateOrderEvent implements CheckinEvent {
  final QueueEntity queue;

  GenerateOrderEvent(this.queue);
}
