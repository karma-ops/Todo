import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:uuid/uuid.dart';

floatingActionButton(context, _formKey, _titleController, _subtitleController,
    _saveForm, primaryColor) {
  return FloatingActionButton(
    onPressed: () {
      String _formatDateTime(DateTime dateTime) {
        return DateFormat('MM/dd/yyyy HH:mm:ss').format(dateTime);
      }

      final DateTime now = DateTime.now();
      final String formattedDateTime = _formatDateTime(now);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: const Color(0xFFeceaed),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Form(
                key: _formKey,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(child: textWidget('Add Task', 20.0, primaryColor)),
                      textField(_titleController, 'Enter the title of the task',
                          'Enter the title..', 'title'),
                      textField(
                          _subtitleController,
                          'Enter the body of the task',
                          'Enter the task..',
                          'subtitle'),
                      TextButton(
                        child: Container(
                          width: 80,
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: textWidget('Save', 14.0, Colors.white),
                          ),
                        ),
                        onPressed: () {
                          var uuid = const Uuid().v1();
                          _saveForm();
                          if (_titleController.text != '' &&
                              _subtitleController.text != '') {
                            Navigator.pop(context);
                            Provider.of<TodoProvider>(context, listen: false)
                                .addTaskList(TodoModel(
                                    title: _titleController.text,
                                    subTitle: _subtitleController.text,
                                    status: false,
                                    date: formattedDateTime,
                                    id: uuid,
                                    fontSize: 16.0,
                                    alignment: 'left',
                                    pinned: false));
                            _titleController.text = '';
                            _subtitleController.text = '';
                          }
                        },
                      ),
                    ],
                  ),
                )),
          );
        },
      );
    },
    tooltip: 'Add Task',
    backgroundColor: primaryColor,
    child: const Icon(Icons.add),
  );
}
