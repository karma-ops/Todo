import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/providers/todo_provider.dart';

willPopScope(_titleController, _subtitleController, context, widget) {
  if (_titleController.text !=
          Provider.of<TodoProvider>(context, listen: false)
              .taskList[widget.taskIndex!]
              .title ||
      _subtitleController.text !=
          Provider.of<TodoProvider>(context, listen: false)
              .taskList[widget.taskIndex!]
              .subTitle) {
    // print(true);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialogDiscard(context);
      },
    );
    return Future.value(true);
  } else {
    Provider.of<TodoProvider>(context, listen: false).sortTasks();
    // print(false);
    return Navigator.canPop(context);
  }
}
