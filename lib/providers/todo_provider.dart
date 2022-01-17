import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/todo_model.dart';

late SharedPreferences _prefs;

class TodoProvider extends ChangeNotifier {
// default values

  String _sortValue = 'All';
  String _radioValue = 'Every Minute';
  String _rHours = '0';
  String _rMinutes = '0';
  String _rSeconds = '1';
  bool _isLoading = true;
  final _kPrimaryColor = const Color(0XFF2e2532);

// getters

  String get rHours => _rHours;
  String get rMinutes => _rMinutes;
  String get rSeconds => _rSeconds;
  String get radioValue => _radioValue;
  String get sortValue => _sortValue;
  bool get isLoading => _isLoading;
  Color get kPrimaryColor => _kPrimaryColor;

  List<TodoModel> _taskList = [];
  final List<TodoModel> _sharedPrefList = [];

  List<TodoModel> get taskList => _taskList;

// load tasks from Shared Prefs

  getTaskItems() async {
    _prefs = await SharedPreferences.getInstance();
    var jsonList = _prefs.getString('toDoList');
    try {
      if (jsonList == null) {
        // print('null printed');
        _isLoading = true;
      } else {
        _isLoading = false;
        var convert = await json.decode(jsonList);
        await convert!.forEach((e) {
          _sharedPrefList.add(TodoModel.fromJson(e));
        });
        // print(_sharedPrefList);
      }
    } catch (e) {
      // print(e.toString());
    }
    _taskList = _sharedPrefList;
    sortTasks();
    notifyListeners();
  }

  // sort tasks according to the date

  sortTasks() {
    _taskList.sort((a, b) {
      var aDate = a.date;
      var bDate = b.date;
      return bDate!.compareTo(aDate!);
    });
    notifyListeners();
  }

  // add tasks

  addTaskList(item) {
    _taskList.add(item);
    sortTasks();
    updatePref();
    notifyListeners();
  }

  // delete tasks

  deleteTask(index) {
    _taskList.removeAt(index);
    sortTasks();
    updatePref();
    notifyListeners();
  }

  // mark as done

  markAsDone(index) {
    _taskList[index].status = true;
    updatePref();
    notifyListeners();
  }

  // unDo

  unDo(index) {
    _taskList[index].status = false;
    updatePref();
    notifyListeners();
  }

  // clear all action

  clearAll() {
    _taskList.length = 0;
    updatePref();
    notifyListeners();
  }

  // edit the text

  editText(index, title, subtitle) {
    String _formatDateTime(DateTime dateTime) {
      return DateFormat('MM/dd/yyyy HH:mm:ss').format(dateTime);
    }

    _taskList[index].title = title;
    _taskList[index].subTitle = subtitle;

    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    _taskList[index].date = formattedDateTime;
    updatePref();
    notifyListeners();
  }

  // update the local prefs

  updatePref() async {
    _prefs = await SharedPreferences.getInstance();
    var json = jsonEncode(_taskList.map((e) => e.toJson()).toList());
    _prefs.setString('toDoList', json);
    notifyListeners();
  }

  // clear all data

  clearData() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    // print("Data Cleared");
  }

  // change the font size

  void changeFontSize(value, index) {
    _taskList[index].fontSize = value;
    updatePref();
    notifyListeners();
  }

  // change the alignment

  void changeAlignment(value, index) {
    _taskList[index].alignment = value;
    updatePref();
    notifyListeners();
  }

  // set reminder

  setReminder(seconds, minutes, hours) {
    _rHours = hours;
    _rMinutes = minutes;
    _rSeconds = seconds;
    notifyListeners();
  }

  // change Radio for periodic reminder

  changeRadio(value) {
    _radioValue = value;
    notifyListeners();
  }

  // change the sort value

  changeSortValue(value) {
    _sortValue = value;
    notifyListeners();
  }

  // update pin status

  changePinStatus(status, index) {
    _taskList[index].pinned = status;
    updatePref();
    notifyListeners();
  }
}
