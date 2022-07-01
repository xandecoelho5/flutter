import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

abstract class IUpdateQueue {
  Future<void> call(QueueEntity queue);
}

class UpdateQueue implements IUpdateQueue {
  final IQueueRepository repository;

  UpdateQueue(this.repository);

  @override
  Future<void> call(QueueEntity queue) async {
    await repository.updateQueue(queue);
  }
}
