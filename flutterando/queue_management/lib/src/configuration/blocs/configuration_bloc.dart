import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue_management/src/configuration/events/configuration_events.dart';
import 'package:queue_management/src/configuration/states/configuration_state.dart';
import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/usecases/add_new_queue.dart';
import 'package:queue_management/src/queue/domain/usecases/get_all_queues.dart';
import 'package:queue_management/src/queue/domain/usecases/remove_queue.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final IGetAllQueues getAllQueuesUsecase;
  final IAddNewQueue addNewQueueUsecase;
  final IRemoveQueue removeQueueUsecase;

  ConfigurationBloc(
    this.getAllQueuesUsecase,
    this.addNewQueueUsecase,
    this.removeQueueUsecase,
  ) : super(EmptyConfigurationState()) {
    on<FetchQueues>(_fetchQueues, transformer: restartable());
    on<AddNewQueueEvent>(_addNewQueue, transformer: sequential());
    on<RemoveQueueEvent>(_removeQueue, transformer: sequential());
  }

  Future<void> _fetchQueues(event, emit) async {
    emit(LoadingConfigurationState());

    await emit.onEach<List<QueueEntity>>(
      getAllQueuesUsecase.call(),
      onData: (queues) => emit(LoadedConfigurationState(queues)),
    );
  }

  Future<void> _addNewQueue(AddNewQueueEvent event, emit) async {
    await addNewQueueUsecase.call(event.queue);
  }

  Future<void> _removeQueue(RemoveQueueEvent event, emit) async {
    await removeQueueUsecase.call(event.queue);
  }
}
