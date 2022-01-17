import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';

import '../components.dart';
import '../constants_and_variables.dart';

// Discard dialog after not saving the file

// bottom navigation and it's function

setReminderType(context, widget, todoData, type, typeName, item) {
  return Expanded(
    child: Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            textWidget(typeName, 14.0, kPrimaryColor),
            dropdownTimer(context, widget, todoData, item, type),
          ],
        ),
      ),
    ),
  );
}

radioItems(todoData, context, type) {
  return Consumer<TodoProvider>(
    builder: (context, newData, child) => Expanded(
      child: ListTile(
        title: textWidget(type, 14.0, kPrimaryColor),
        leading: Radio(
            activeColor: kPrimaryColor,
            value: "$type",
            groupValue: newData.radioValue,
            onChanged: (value) {
              Provider.of<TodoProvider>(context, listen: false)
                  .changeRadio(value);
            }),
      ),
    ),
  );
}

// dropdown icons for alignment

giveIcon(value, color) {
  if (value == 'center') {
    return Icon(Icons.format_align_center, color: color, size: 20);
  } else if (value == 'justify') {
    return Icon(Icons.format_align_justify, color: color, size: 20);
  } else if (value == 'left') {
    return Icon(Icons.format_align_left, color: color, size: 20);
  } else {
    return Icon(Icons.format_align_right, color: color, size: 20);
  }
}

// alignment dropdown titles

getAlignment(value) {
  if (value == 'center') {
    return TextAlign.center;
  } else if (value == 'justify') {
    return TextAlign.justify;
  } else if (value == 'left') {
    return TextAlign.left;
  } else {
    return TextAlign.right;
  }
}

// dropdown for reminder timer

dropdownTimer(context, widget, todoData, List<String> item, which) {
  var prov = Provider.of<TodoProvider>(context, listen: false);
  return DropdownButtonHideUnderline(
    child: ButtonTheme(
      alignedDropdown: true,
      child: Consumer<TodoProvider>(
        builder: (context, todoDataNew, child) => DropdownButton(
          iconEnabledColor: kPrimaryColor,
          dropdownColor: kBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          isDense: true,
          hint: which == 'rSeconds'
              ? Text(todoDataNew.rSeconds)
              : which == 'rMinutes'
                  ? Text(todoDataNew.rMinutes)
                  : Text(todoDataNew.rHours),
          menuMaxHeight: 200,
          style: const TextStyle(color: kPrimaryColor),
          onChanged: (String? newValue) {
            if (which == 'rSeconds') {
              prov.setReminder(newValue, prov.rMinutes, prov.rHours);
            } else if (which == 'rMinutes') {
              prov.setReminder(prov.rSeconds, newValue, prov.rHours);
            } else {
              prov.setReminder(prov.rSeconds, prov.rMinutes, newValue);
            }
          },
          items: item.map((String str) {
            return DropdownMenuItem(
              value: str,
              child: Row(
                children: [
                  Text(str),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}
