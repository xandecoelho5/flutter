import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:queue_management/src/configuration/blocs/configuration_bloc.dart';
import 'package:queue_management/src/configuration/events/configuration_events.dart';
import 'package:queue_management/src/configuration/states/configuration_state.dart';

import '../../../mocks/mocks.dart';

void main() {
  final getAll = GetAllQueuesMock();
  final addNew = AddNewQueueMock();
  final remove = RemoveQueueMock();
  final entity = QueueEntityMock();

  blocTest<ConfigurationBloc, ConfigurationState>(
    'FetchQueues',
    build: () {
      when(() => getAll.call()).thenAnswer((_) => Stream.value([]));

      return ConfigurationBloc(getAll, addNew, remove);
    },
    act: (bloc) => bloc.add(FetchQueues()),
    expect: () => [
      isA<LoadingConfigurationState>(),
      isA<LoadedConfigurationState>(),
    ],
  );

  blocTest<ConfigurationBloc, ConfigurationState>(
    'AddNewQueueEvent',
    build: () {
      when(() => addNew.call(entity)).thenAnswer((_) => Future.value());

      return ConfigurationBloc(getAll, addNew, remove);
    },
    act: (bloc) => bloc.add(AddNewQueueEvent(entity)),
    expect: () => [],
  );

  blocTest<ConfigurationBloc, ConfigurationState>(
    'RemoveQueueEvent',
    build: () {
      when(() => remove.call(entity)).thenAnswer((_) => Future.value());

      return ConfigurationBloc(getAll, addNew, remove);
    },
    act: (bloc) => bloc.add(RemoveQueueEvent(entity)),
    expect: () => [],
  );

  blocTest<ConfigurationBloc, ConfigurationState>(
    'FetchQueues with error',
    build: () {
      when(() => getAll.call())
          .thenAnswer((_) => Stream.error(Exception('Error')));
      return ConfigurationBloc(getAll, addNew, remove);
    },
    act: (bloc) => bloc.add(FetchQueues()),
    expect: () => [
      isA<LoadingConfigurationState>(),
      isA<ExceptionConfigurationState>(),
    ],
  );
}
