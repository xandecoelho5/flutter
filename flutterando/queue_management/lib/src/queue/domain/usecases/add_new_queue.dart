import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/repositories/queue_repository.dart';

abstract class IAddNewQueue {
  Future<void> call(QueueEntity queue);
}

class AddNewQueue implements IAddNewQueue {
  final IQueueRepository repository;

  AddNewQueue(this.repository);

  @override
  Future<void> call(QueueEntity queue) async {
    return await repository.addQueue(queue);
  }
}
