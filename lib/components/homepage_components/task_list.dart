import 'package:flutter/material.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

import '../components.dart';
import '../constants_and_variables.dart';

// homepage full task list

Expanded taskList() {
  return Expanded(
      flex: 3,
      child: Consumer<TodoProvider>(
        builder: (context, todoData, child) {
          return GestureDetector(
            onVerticalDragStart: (details) {
              // print(details);
            },
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: todoData.taskList.isEmpty
                  ? Center(
                      child: textWidget('Add a new task', 18.0, kPrimaryColor))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DropdownButtonHideUnderline(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: kBackgroundColor,
                                    borderRadius: BorderRadius.circular(20),
                                    isDense: true,
                                    icon: const SizedBox(),
                                    hint: Row(
                                      children: [
                                        const Icon(Icons.sort_outlined,
                                            color: kPrimaryColor),
                                        const SizedBox(width: 20),
                                        textWidget(todoData.sortValue, 14.0,
                                            kPrimaryColor),
                                      ],
                                    ),
                                    style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        color: kPrimaryColor),
                                    onChanged: (String? newValue) {
                                      Provider.of<TodoProvider>(context,
                                              listen: false)
                                          .changeSortValue(newValue);
                                    },
                                    items: sortItems.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: SizedBox(
                                          width: 130,
                                          child: textWidget(
                                              items, 14.0, kPrimaryColor),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) =>
                                            alertClearAll(context));
                                  },
                                  child: textWidget(
                                      'Clear All', 14.0, kTextDarkColor))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Scrollbar(
                          showTrackOnHover: true,
                          child: ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                if (todoData.sortValue == 'Completed tasks') {
                                  return todoData.taskList[index].status == true
                                      ? listView(context, index, todoData)
                                      : const SizedBox();
                                } else if (todoData.sortValue ==
                                    'Incomplete tasks') {
                                  return todoData.taskList[index].status ==
                                          false
                                      ? listView(context, index, todoData)
                                      : const SizedBox();
                                } else if (todoData.sortValue ==
                                    'Pinned tasks') {
                                  return todoData.taskList[index].pinned == true
                                      ? listView(context, index, todoData)
                                      : const SizedBox();
                                } else {
                                  return listView(context, index, todoData);
                                }
                              },
                              itemCount: todoData.taskList.length),
                        )
                      ],
                    ),
            ),
          );
        },
      ));
}

listView(context, index, todoData) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, 'detail', arguments: {'taskIndex': index});
    },
    child: Dismissible(
      key: Key(UniqueKey().toString()),
      direction: DismissDirection.horizontal,
      confirmDismiss: (DismissDirection direction) async {
        if (direction == DismissDirection.endToStart) {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return alertDialog(context, index);
            },
          );
        } else {
          if (todoData.taskList[index].status == false) {
            todoData.markAsDone(index);
          } else {
            todoData.unDo(index);
          }
        }
      },
      child: Container(
        margin: index == 0
            ? const EdgeInsets.only(top: 0)
            : const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
          color: todoData.taskList[index].status == false
              ? todoData.taskList[index].pinned == false
                  ? kPrimaryColor
                  : const Color(0XFF574d5b)
              : const Color(0XFF8ca551),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(Icons.album,
                        size: 16,
                        color: todoData.taskList[index].status == false
                            ? Colors.orange.shade800
                            : Colors.green.shade800)),
                IconButton(
                    padding: const EdgeInsets.all(0),
                    tooltip:
                        todoData.taskList[index].pinned ? "Pinned" : 'Unpinned',
                    splashRadius: 20.0,
                    onPressed: () {
                      if (todoData.taskList[index].pinned == false) {
                        todoData.changePinStatus(true, index);
                      } else {
                        todoData.changePinStatus(false, index);
                      }
                    },
                    icon: todoData.taskList[index].pinned
                        ? const Icon(Octicons.pin,
                            color: Colors.white, size: 18)
                        : const Icon(Typicons.pin_outline,
                            color: Colors.white, size: 18)),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, top: 5),
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  margin:
                                      const EdgeInsets.only(bottom: 5, top: 5),
                                  child: textWidget(
                                      '${todoData.taskList[index].title}',
                                      17.0,
                                      Colors.white),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: textWidget(
                                    '${todoData.taskList[index].subTitle.length > 50 ? todoData.taskList[index].subTitle.substring(0, 50) + '...' : todoData.taskList[index].subTitle}',
                                    12.0,
                                    Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, right: 15),
                        padding: const EdgeInsets.only(left: 10),
                        child: textWidget(
                            '${todoData.taskList[index].date?.substring(0, 10)}',
                            12.0,
                            Colors.white),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      todoData.taskList[index].status == false
                          ? TextButton(
                              child: textWidget(
                                  'Mark As Done', 12.0, Colors.white),
                              onPressed: () {
                                Provider.of<TodoProvider>(context,
                                        listen: false)
                                    .markAsDone(index);
                              },
                            )
                          : TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: textWidget('Undo', 12.0, Colors.white),
                              onPressed: () {
                                Provider.of<TodoProvider>(context,
                                        listen: false)
                                    .unDo(index);
                              },
                            ),
                      TextButton(
                        child: textWidget('Remove', 12.0, Colors.white),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alertDialog(context, index);
                            },
                          );
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
