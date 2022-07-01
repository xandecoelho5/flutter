import 'package:mocktail/mocktail.dart';
import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/repositories/queue_repository.dart';
import 'package:queue_management/src/queue/domain/usecases/add_new_queue.dart';
import 'package:queue_management/src/queue/domain/usecases/get_all_queues.dart';
import 'package:queue_management/src/queue/domain/usecases/remove_queue.dart';
import 'package:queue_management/src/queue/infra/datasource/queue_datasource.dart';

class QueueRepositoryMock extends Mock implements IQueueRepository {}

class QueueEntityMock extends Mock implements QueueEntity {}

class QueueDatasourceMock extends Mock implements IQueueDatasource {}

class GetAllQueuesMock extends Mock implements IGetAllQueues {}

class AddNewQueueMock extends Mock implements IAddNewQueue {}

class RemoveQueueMock extends Mock implements IRemoveQueue {}
