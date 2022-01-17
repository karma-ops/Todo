import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/components/detail_components/bottom_navigation.dart';
import 'package:todo/components/detail_components/detail_components.dart';
import 'package:todo/providers/todo_provider.dart';

form(_formKey, context, _titleController, _subtitleController, widget,
    showNotification, _saveForm, snackBar, remindNotification) {
  return Form(
    key: _formKey,
    child: Container(
      margin: const EdgeInsets.only(top: 50),
      child: Consumer<TodoProvider>(
        builder: (context, todoData, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLength: 50,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: _titleController,
                  validator: (value) {
                    return value == '' || value!.isEmpty
                        ? "Cannot leave this field empty"
                        : null;
                  },
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    counterText: '',
                    hintText: _titleController.text,
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    border: InputBorder.none,
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: textWidget(
                    '${todoData.taskList[widget.taskIndex!].date?.substring(0, 10)}'
                    ' /'
                    '${todoData.taskList[widget.taskIndex!].date?.substring(10, 16)}',
                    12.0,
                    Colors.white),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textAlign: getAlignment(
                        todoData.taskList[widget.taskIndex!].alignment),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: todoData.taskList[widget.taskIndex!].fontSize,
                    ),
                    controller: _subtitleController,
                    validator: (value) {
                      return value!.isNotEmpty
                          ? null
                          : "Cannot leave this field empty";
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: _subtitleController.text,
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: todoData.taskList[widget.taskIndex!].fontSize,
                      ),
                      border: InputBorder.none,
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                    ),
                  ),
                ),
              ),
              bottomNavigation(
                  context,
                  _titleController,
                  _subtitleController,
                  showNotification,
                  todoData,
                  widget,
                  _saveForm,
                  snackBar,
                  _formKey,
                  remindNotification),
            ],
          );
        },
      ),
    ),
  );
}
