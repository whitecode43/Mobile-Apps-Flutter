import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/modals/task_data.dart';
import 'package:todoeyflutter/modals/task.dart';

class TasksList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Consumer<TaskData>(builder: (context, taskdata, child) {
        return ListView.builder(
          itemCount: taskdata.taskCount,
          itemBuilder: (context, index) {
            Task currTask = taskdata.tasks[index];
            return TaskTile(
              isChecked: currTask.isDone,
              taskText: currTask.task,
              onLongPressed: () {
                taskdata.deleteTask(currTask);
              },
              checkBoxFunction: (value) {
                taskdata.update(currTask);
              },
            );
          },
        );
      }),
    );
  }
}
