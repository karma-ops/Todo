import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

appBar(context, _titleController, _subtitleController, widget,
    alertDialogDiscard) {
  var todoprovider = Provider.of<TodoProvider>(context, listen: false);
  return Positioned(
    top: 0.0,
    left: -10.0,
    right: 0.0,
    child: AppBar(
      // backwardsCompatibility: false,
      leading: Tooltip(
        message: "Go back",
        child: IconButton(
          icon: const Icon(Icons.arrow_back_sharp, color: Colors.white),
          onPressed: () {
            if (_titleController.text !=
                    todoprovider.taskList[widget.taskIndex!].title ||
                _subtitleController.text !=
                    todoprovider.taskList[widget.taskIndex!].subTitle) {
              // print(true);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alertDialogDiscard(context);
                },
              );
            } else {
              Navigator.pop(context);
              todoprovider.sortTasks();
            }
          },
        ),
      ),
      backgroundColor: Colors.transparent, //You can make this transparent
      elevation: 0.0, //No shadow
    ),
  );
}
