import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:queue_management/src/queue/domain/repositories/queue_repository.dart';
import 'package:queue_management/src/queue/domain/usecases/add_new_queue.dart';
import 'package:queue_management/src/queue/domain/usecases/get_all_queues.dart';
import 'package:queue_management/src/queue/domain/usecases/remove_queue.dart';
import 'package:queue_management/src/queue/external/queue_firestore_datasource.dart';
import 'package:queue_management/src/queue/infra/datasource/queue_datasource.dart';
import 'package:queue_management/src/queue/infra/repositories/queue_repository.dart';

final queueModule = [
  Provider<FirebaseFirestore>.value(value: FirebaseFirestore.instance),
  Provider<IQueueDatasource>(
      create: (context) => QueueFirestoreDatasource(context.read())),
  Provider<IQueueRepository>(
      create: (context) => QueueRepository(context.read())),
  // usecases
  Provider<IGetAllQueues>(create: (context) => GetAllQueues(context.read())),
  Provider<IAddNewQueue>(create: (context) => AddNewQueue(context.read())),
  Provider<IRemoveQueue>(create: (context) => RemoveQueue(context.read())),
];
