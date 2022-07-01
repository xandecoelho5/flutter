import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/repositories/queue_repository.dart';

abstract class IRemoveQueue {
  Future<void> call(QueueEntity queue);
}

class RemoveQueue implements IRemoveQueue {
  final IQueueRepository repository;

  RemoveQueue(this.repository);

  @override
  Future<void> call(QueueEntity queue) async {
    await repository.removeQueue(queue.id);
  }
}
