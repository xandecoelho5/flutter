import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:queue_management/src/configuration/blocs/configuration_bloc.dart';
import 'package:queue_management/src/configuration/events/configuration_events.dart';
import 'package:queue_management/src/configuration/states/configuration_state.dart';

import '../../../mocks/mocks.dart';

void main() {
  blocTest<ConfigurationBloc, ConfigurationState>(
    'configuration bloc ...',
    build: () {
      final usecase = GetAllQueuesMock();
      final addNewQueueUsecase = AddNewQueueMock();
      final removeQueueUsecase = RemoveQueueMock();

      when(() => usecase.call()).thenAnswer((_) => Stream.value([]));

      return ConfigurationBloc(usecase, addNewQueueUsecase, removeQueueUsecase);
    },
    act: (bloc) => bloc.add(FetchQueues()),
    expect: () => [
      isA<LoadingConfigurationState>(),
      isA<LoadedConfigurationState>(),
    ],
  );
}
