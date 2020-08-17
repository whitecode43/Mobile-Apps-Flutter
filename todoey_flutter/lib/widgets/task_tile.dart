import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  TaskTile(
      {this.isChecked,
      this.checkBoxFunction,
      this.taskText,
      this.onLongPressed});
  final bool isChecked;
  final Function checkBoxFunction;
  final Function onLongPressed;
  final String taskText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressUp: onLongPressed,
      child: ListTile(
          title: Text(taskText,
              style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : null)),
          trailing: Checkbox(
              activeColor: Colors.lightBlueAccent,
              value: isChecked,
              onChanged: checkBoxFunction)),
    );
  }
}
