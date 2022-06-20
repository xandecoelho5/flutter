import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:taskly/models/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double _deviceHeight;

  String? _newTaskContent;
  Box? _box;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: _deviceHeight * 0.15,
        title: const Text(
          'Taskly!',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: _tasksView(),
      floatingActionButton: _addTaskButton(),
    );
  }

  Widget _tasksList() {
    final tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = Task.fromMap(tasks[index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
              decoration: task.done ? null : TextDecoration.lineThrough,
            ),
          ),
          subtitle: Text(task.timestamp.toString()),
          trailing: Icon(
            task.done
                ? Icons.check_box_outline_blank_outlined
                : Icons.check_box_outlined,
            color: Colors.red,
          ),
          onTap: () {
            task.done = !task.done;
            _box!.putAt(index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            _box!.deleteAt(index);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopup,
      child: const Icon(Icons.add),
    );
  }

  Widget _tasksView() {
    return FutureBuilder<Box>(
      future: Hive.openBox('tasks'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _box = snapshot.data;
          return _tasksList();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  void _displayTaskPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task!'),
          content: TextField(
            onSubmitted: (value) {
              if (_newTaskContent != null) {
                _box!.add(Task(
                  content: _newTaskContent!,
                  timestamp: DateTime.now(),
                  done: false,
                ).toMap());
                setState(() {
                  _newTaskContent = null;
                  Navigator.pop(context);
                });
              }
            },
            onChanged: (value) => setState(() => _newTaskContent = value),
          ),
        );
      },
    );
  }
}
