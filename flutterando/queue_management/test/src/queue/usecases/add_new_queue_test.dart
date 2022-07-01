import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:queue_management/src/queue/domain/usecases/add_new_queue.dart';

import '../../../mocks/mocks.dart';

void main() {
  test('deve adicionar uma nova queueEntity', () {
    final repository = QueueRepositoryMock();
    final queue = QueueEntityMock();

    when(() => repository.addQueue(queue)).thenAnswer((_) => Future.value());
    final usecase = AddNewQueue(repository);

    // completes verifica se a chamada do método async foi completada
    expect(usecase.call(queue), completes);
  });
}
