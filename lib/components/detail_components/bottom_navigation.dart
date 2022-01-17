import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/components/detail_components/detail_components.dart';
import 'package:todo/providers/todo_provider.dart';

import '../constants_and_variables.dart';

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
    remindNotification) {
  var todoprovider = Provider.of<TodoProvider>(context, listen: false);
  return InkWell(
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () {
      FocusScope.of(context).unfocus();
    },
    child: Container(
      height: MediaQuery.of(context).size.height * 0.065,
      color: Colors.white24,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Tooltip(
              message: 'Set scheduled reminders',
              child: IconButton(
                  splashRadius: 20.0,
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            decoration: const BoxDecoration(
                                color: kBackgroundColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 0, 0),
                                      child: textWidget(
                                          'Add a scheduled reminder',
                                          20.0,
                                          kPrimaryColor),
                                    ),
                                  ),
                                ),
                                setReminderType(context, widget, todoData,
                                    'rSeconds', 'Seconds', seconds),
                                setReminderType(context, widget, todoData,
                                    'rMinutes', 'Minutes', minutes),
                                setReminderType(context, widget, todoData,
                                    'rHours', 'Hours', hours),
                                Expanded(
                                    child: Center(
                                        child: TextButton(
                                  onPressed: () {
                                    Provider.of<TodoProvider>(context,
                                            listen: false)
                                        .setReminder(
                                            todoprovider.rSeconds,
                                            todoprovider.rMinutes,
                                            todoprovider.rHours);
                                    showNotification(
                                        Provider.of<TodoProvider>(context,
                                                listen: false)
                                            .rSeconds,
                                        Provider.of<TodoProvider>(context,
                                                listen: false)
                                            .rMinutes,
                                        Provider.of<TodoProvider>(context,
                                                listen: false)
                                            .rHours,
                                        'scheduled',
                                        '');
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      padding: const EdgeInsets.all(10),
                                      child: textWidget(
                                          'Set Reminder', 16.0, Colors.white)),
                                )))
                              ],
                            ));
                      },
                    );
                    // showNotification();
                  },
                  icon: const Icon(Icons.notification_add_outlined,
                      color: Colors.white))),
          Tooltip(
              message: 'Set periodical reminders',
              child: IconButton(
                  splashRadius: 20.0,
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                            decoration: const BoxDecoration(
                                color: kBackgroundColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          15, 10, 0, 0),
                                      child: textWidget(
                                          'Add a periodic reminder',
                                          20.0,
                                          kPrimaryColor),
                                    ),
                                  ),
                                ),
                                radioItems(todoData, context, 'Every Minute'),
                                radioItems(todoData, context, 'Hourly'),
                                radioItems(todoData, context, 'Daily'),
                                radioItems(todoData, context, 'Weekly'),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Center(
                                            child: TextButton(
                                      onPressed: () {
                                        todoprovider.setReminder(
                                            todoprovider.rSeconds,
                                            todoprovider.rMinutes,
                                            todoprovider.rHours);
                                        showNotification(
                                            todoprovider.rSeconds,
                                            todoprovider.rMinutes,
                                            todoprovider.rHours,
                                            'periodic',
                                            todoprovider.radioValue);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: textWidget('Set Reminder',
                                                14.0, Colors.white),
                                          )),
                                    ))),
                                    Expanded(
                                        child: Center(
                                            child: TextButton(
                                      onPressed: () {
                                        remindNotification
                                            .cancel(widget.taskIndex);
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: textWidget(
                                                'Stop', 14.0, Colors.white),
                                          )),
                                    ))),
                                    Expanded(
                                        child: Center(
                                            child: TextButton(
                                      onPressed: () {
                                        remindNotification.cancelAll();
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.all(10),
                                          child: Center(
                                            child: textWidget(
                                                'Stop all', 14.0, Colors.white),
                                          )),
                                    ))),
                                  ],
                                )
                              ],
                            ));
                      },
                    );
                    // showNotification();
                  },
                  icon: const Icon(Icons.notification_important_rounded,
                      color: Colors.white))),
          Center(
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  iconEnabledColor: Colors.white,
                  dropdownColor: kBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                  isDense: true,
                  hint: Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: textWidget(
                        todoData.taskList[widget.taskIndex!].fontSize
                            .toString()
                            .replaceAll('.0', ''),
                        16.0,
                        Colors.white),
                  ),
                  menuMaxHeight: 200,
                  style: const TextStyle(color: kPrimaryColor),
                  onChanged: (String? newValue) {
                    double dblValue = double.parse(newValue!);
                    todoprovider.changeFontSize(dblValue, widget.taskIndex);
                  },
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Row(
                        children: [
                          Text(items,
                              style: TextStyle(
                                  color: items ==
                                          todoData.taskList[widget.taskIndex!]
                                              .fontSize
                                              .toString()
                                              .replaceAll('.0', '')
                                      ? Colors.red
                                      : kPrimaryColor)),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          Stack(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: giveIcon(todoData.taskList[widget.taskIndex].alignment,
                      Colors.white),
                ),
              ),
              Center(
                child: DropdownButtonHideUnderline(
                  child: ButtonTheme(
                    alignedDropdown: true,
                    child: DropdownButton(
                      iconEnabledColor: Colors.white,
                      dropdownColor: kBackgroundColor,
                      borderRadius: BorderRadius.circular(20),
                      isDense: true,
                      // menuMaxHeight: 200,
                      style: const TextStyle(color: kPrimaryColor),
                      onChanged: (String? newValue) {
                        todoprovider.changeAlignment(
                            newValue!.toLowerCase(), widget.taskIndex);
                      },
                      items: fontStyleItems.map((String items) {
                        return DropdownMenuItem(
                            value: items,
                            child: giveIcon(items, kPrimaryColor));
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Tooltip(
            message: todoData.taskList[widget.taskIndex].pinned
                ? "Pinned"
                : 'Unpinned',
            child: IconButton(
                splashRadius: 20.0,
                onPressed: () {
                  if (todoData.taskList[widget.taskIndex].pinned == false) {
                    todoData.changePinStatus(true, widget.taskIndex);
                  } else {
                    todoData.changePinStatus(false, widget.taskIndex);
                  }
                },
                icon: todoData.taskList[widget.taskIndex].pinned
                    ? const Icon(Octicons.pin, color: Colors.white, size: 20)
                    : const Icon(Typicons.pin_outline,
                        color: Colors.white, size: 20)),
          ),
          Tooltip(
            message: "Save",
            child: IconButton(
                splashRadius: 20.0,
                onPressed: () {
                  _saveForm();
                  if (_titleController.text ==
                          todoprovider.taskList[widget.taskIndex!].title &&
                      _subtitleController.text ==
                          todoprovider.taskList[widget.taskIndex!].subTitle) {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    todoprovider.editText(widget.taskIndex!,
                        _titleController.text, _subtitleController.text);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                icon: const Icon(
                  Icons.save_sharp,
                  color: Colors.white,
                  size: 20,
                )),
          )
        ],
      ),
    ),
  );
}
