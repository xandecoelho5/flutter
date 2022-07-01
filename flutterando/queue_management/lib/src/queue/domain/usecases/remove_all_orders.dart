import 'package:queue_management/src/queue/domain/repositories/queue_repository.dart';

abstract class IRemoveAllOrders {
  Future<void> call();
}

class RemoveAllOrders implements IRemoveAllOrders {
  final IQueueRepository repository;

  RemoveAllOrders(this.repository);

  @override
  Future<void> call() async {
    await repository.removeAllOrders();
  }
}
