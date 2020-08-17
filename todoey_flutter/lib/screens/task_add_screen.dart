import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoeyflutter/modals/task_data.dart';

class TaskAdder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String typedTask;
    return Container(
        color: Color(0xFF757575),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'Add Text',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlueAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextField(
                  textAlign: TextAlign.center,
                  autofocus: true,
                  onChanged: (value) {
                    typedTask = value;
                  },
                ),
                FlatButton(
                  color: Colors.lightBlueAccent,
                  child: Text(
                    'Add',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    if (typedTask != null)
                      Provider.of<TaskData>(context).addTask(typedTask);
                    Navigator.pop(context);
                  },
                )
              ]),
        ));
  }
}
