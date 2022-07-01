import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/repositories/queue_repository.dart';

abstract class IGetAllQueues {
  Stream<List<QueueEntity>> call();
}

class GetAllQueues implements IGetAllQueues {
  final IQueueRepository repository;

  GetAllQueues(this.repository);

  @override
  Stream<List<QueueEntity>> call() {
    return repository.getAllQueues();
  }
}
