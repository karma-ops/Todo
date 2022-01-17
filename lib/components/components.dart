import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/constants_and_variables.dart';
import 'package:todo/providers/todo_provider.dart';

// for Text() widget

Text textWidget(text, fontSize, color) {
  return Text('$text',
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          // fontFamily: 'Montserrat',
          fontWeight: text == 'Completed' ||
                  text == 'Latest Entries : ' ||
                  text == 'Add Task' ||
                  text == 'Confirm' ||
                  text == 'Add a scheduled reminder' ||
                  text == 'Add a periodic reminder' ||
                  text == 'Add a periodic reminder' ||
                  fontSize == 25.0 ||
                  fontSize == 17.0
              ? FontWeight.bold
              : FontWeight.normal,
          overflow: text == 'Are you sure you wish to delete this item?' ||
                  text == 'Incomplete tasks' ||
                  text == 'Completed tasks' ||
                  text.length < 40
              ? TextOverflow.visible
              : TextOverflow.ellipsis));
}

// Alert Dialog after deletion

AlertDialog alertDialog(context, index) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    backgroundColor: kBackgroundColor,
    title: textWidget('Confirm', 20.0, kPrimaryColor),
    content: textWidget(
        'Are you sure you wish to delete this item?', 16.0, kPrimaryColor),
    actions: <Widget>[
      TextButton(
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: textWidget('Yes', 14.0, Colors.white),
          ),
        ),
        onPressed: () {
          Provider.of<TodoProvider>(context, listen: false).deleteTask(index);
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: textWidget('No', 14.0, Colors.white),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
}

//alert for discard

AlertDialog alertDialogDiscard(context) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    backgroundColor: kBackgroundColor,
    title: textWidget('Confirm', 20.0, kPrimaryColor),
    content: textWidget('Discard changes?', 16.0, kPrimaryColor),
    actions: <Widget>[
      TextButton(
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: textWidget('Yes', 14.0, Colors.white),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: textWidget('No', 14.0, Colors.white),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
}
//alert for clear all

AlertDialog alertClearAll(context) {
  return AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    backgroundColor: kBackgroundColor,
    title: textWidget('Confirm', 20.0, kPrimaryColor),
    content:
        textWidget('Are you sure to clear all the tasks?', 16.0, kPrimaryColor),
    actions: <Widget>[
      TextButton(
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: textWidget('Yes', 14.0, Colors.white),
          ),
        ),
        onPressed: () {
          Provider.of<TodoProvider>(context, listen: false).clearAll();
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: Container(
          width: 80,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: textWidget('No', 14.0, Colors.white),
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );
}

// Popup task fill in fields

TextFormField textField(controller, validateText, hintText, whichController) {
  return TextFormField(
    style: const TextStyle(fontFamily: 'Montserrat', fontSize: 14),
    keyboardType: TextInputType.multiline,
    maxLines: whichController == 'subtitle' ? 4 : null,
    maxLength: whichController == 'title' ? 50 : null,
    controller: controller,
    validator: (value) {
      return value!.isNotEmpty ? null : "$validateText";
    },
    cursorColor: kPrimaryColor,
    decoration: InputDecoration(
      contentPadding:
          const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      hintText: hintText,
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: const BorderSide(color: kPrimaryColor)),
      focusColor: kPrimaryColor,
      hoverColor: kPrimaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
