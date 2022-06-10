import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

import 'task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.taskCount,
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              isChecked: task.isDone,
              taskTitle: task.name,
              checkboxCallback: (checkboxState) => taskData.updateTask(task),
              longPressCallback: () => taskData.deleteTask(task),
            );
          },
        );
      },
    );
  }
}
