import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:queue_management/src/configuration/blocs/configuration_bloc.dart';
import 'package:queue_management/src/configuration/events/configuration_events.dart';
import 'package:queue_management/src/configuration/states/configuration_state.dart';

import '../models/queue_model.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage>
    with CompleteStateMixin {
  @override
  void completeState() {
    context.read<ConfigurationBloc>().add(FetchQueues());
  }

  void _addNewQueueDialog() {
    showDialog(
        context: context,
        builder: (context) {
          var queue = QueueModel.empty();

          return AlertDialog(
            title: const Text('Nova fila'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (value) => queue = queue.copyWith(title: value),
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) => queue = queue.copyWith(abbr: value),
                  decoration: const InputDecoration(
                    labelText: 'Abreviação',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  onChanged: (value) {
                    queue = queue.copyWith(priority: int.tryParse(value));
                  },
                  decoration: const InputDecoration(
                    labelText: 'Prioridade',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<ConfigurationBloc>()
                      .add(AddNewQueueEvent(queue));
                  Navigator.pop(context);
                },
                child: const Text('Adicionar'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ConfigurationBloc>();
    final state = bloc.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'FILAS',
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: _addNewQueueDialog,
                    icon: const Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              if (state is LoadedConfigurationState)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.queues.length,
                  itemBuilder: (context, index) {
                    final queue = state.queues[index];
                    return ListTile(
                      title: Text(
                        '${queue.title} - ${queue.abbr}',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text('${queue.priority} de prioridade'),
                      trailing: IconButton(
                        onPressed: () => bloc.add(RemoveQueueEvent(queue)),
                        icon: const Icon(Icons.remove, color: Colors.red),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 10),
              const Text(
                'CONTROLE',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  bloc.add(RemoveAllOrdersEvent());
                },
                child: const Text('Reiniciar filas'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin CompleteStateMixin<T extends StatefulWidget> on State<T> {
  void completeState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      completeState();
    });
  }
}
