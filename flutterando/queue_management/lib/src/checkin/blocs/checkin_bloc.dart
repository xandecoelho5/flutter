import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue_management/src/checkin/events/checkin_event.dart';
import 'package:queue_management/src/checkin/states/checkin_state.dart';

import '../../queue/domain/usecases/generate_order.dart';
import '../../queue/domain/usecases/get_all_queues.dart';
import '../../queue/domain/usecases/update_queue.dart';

class CheckinBloc extends Bloc<CheckinEvent, CheckinState> {
  final IGetAllQueues getAllQueues;
  final IGenerateOrder generateOrder;
  final IUpdateQueue updateQueue;

  CheckinBloc(
    this.getAllQueues,
    this.generateOrder,
    this.updateQueue,
  ) : super(InitialCheckinState()) {
    on<FetchAllQueues>(_fetchAllQueues);
    on<PrintOrder>(_printOrder);
    on<GenerateOrderEvent>(_generateOrder);
  }

  Future<void> _fetchAllQueues(event, emit) async {
    await emit.onEach(
      getAllQueues.call(),
      onData: (queues) => emit(SuccessCheckinState(queues)),
    );
  }

  void _printOrder(PrintOrder event, emit) {}

  void _generateOrder(GenerateOrderEvent event, emit) async {
    final queue = generateOrder.call(event.queue);
    final order = queue.orders.last;

    await updateQueue.call(queue);

    emit(GeneratedOrderCheckinState(order));
  }
}
