import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/infra/repositories/queue_repository.dart';

import '../../../../mocks/mocks.dart';

void main() {
  test('queue repository getAllQueues', () {
    final datasource = QueueDatasourceMock();
    when(() => datasource.getAllQueues()).thenAnswer(
      (_) => Stream.value([
        {
          'id': 'dsfdfd',
          'title': 'title',
          'priority': 1,
          'abbr': 'sd',
          'orders': [
            {
              'id': 'dsfdfd',
              'position': 1,
              'status': 'attending',
              'timestamp': '2022-03-31 18:37:30',
            },
          ]
        }
      ]),
    );

    final repository = QueueRepository(datasource);

    final result = repository.getAllQueues();

    expect(result, emits(isA<List<QueueEntity>>()));
  });

  test('deve adicionar uma nova queue', () {
    final datasource = QueueDatasourceMock();
    const queue = QueueEntity(
      id: 'aodkas',
      title: 'title',
      abbr: 'abbr',
      priority: 1,
      orders: [],
    );
    when(() => datasource.addQueue(any())).thenAnswer((_) => Future.value());
    final repository = QueueRepository(datasource);

    expect(repository.addQueue(queue), completes);
  });
}
