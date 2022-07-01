import 'package:flutter_test/flutter_test.dart';
import 'package:queue_management/src/queue/domain/entities/queue_entity.dart';
import 'package:queue_management/src/queue/domain/usecases/generate_order.dart';

void main() {
  test('deve gerar uma nova order', () {
    final usecase = GenerateOrder();
    const queue = QueueEntity(
      id: 'dsad',
      title: 'title',
      abbr: 'abbr',
      priority: 1,
      orders: [],
    );

    final result = usecase.call(queue);

    expect(result.orders.length, 1);
    expect(result.orders.first.id, '0001');
    expect(result.orders.first.position, 1);
  });
}
