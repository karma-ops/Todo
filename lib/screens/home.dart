import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/homepage_components/calculate_progress.dart';
import 'package:todo/components/homepage_components/floating_action_add_task.dart';
import 'package:todo/components/homepage_components/progress_indicator.dart';
import 'package:todo/components/homepage_components/settings_icon.dart';
import 'package:todo/components/homepage_components/task_list.dart';
import 'package:todo/components/homepage_components/time.dart';
import 'package:todo/providers/progress_indicator.dart';
import 'package:todo/providers/time_provider.dart';
import 'package:todo/providers/todo_provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  dynamic timer;
  String formattedDateTime = '';

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      var timerInfo = Provider.of<TimeProvider>(context, listen: false);
      timerInfo.getTime();
    });
    final DateTime now = DateTime.now();

    String _formatDateTime(DateTime dateTime) {
      return DateFormat('MM/dd/yyyy HH:mm:ss').format(dateTime);
    }

    formattedDateTime = _formatDateTime(now);
    Provider.of<TodoProvider>(context, listen: false).getTaskItems();
    Provider.of<IndicatorProvider>(context, listen: false).getIndicatorValue();
    Provider.of<TimeProvider>(context, listen: false).getTimerValue();
  }

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var todoprovider = Provider.of<TodoProvider>(context, listen: false);
    Color primaryColor = todoprovider.kPrimaryColor;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: primaryColor, // navigation bar color
      statusBarColor: primaryColor, // status bar color
    ));
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                settingsIcon(context),
                Consumer<TimeProvider>(
                    builder: (context, data, child) => data.showTimer == false
                        ? const SizedBox()
                        : time(formattedDateTime, context)),
              ],
            ),
            Consumer<IndicatorProvider>(
                builder: (context, data, child) => data.showIndicator == false
                    ? const SizedBox()
                    : progressIndicator(calculateProgress, context)),
            taskList(),
          ],
        ),
      ),
      floatingActionButton: floatingActionButton(context, _formKey,
          _titleController, _subtitleController, _saveForm, primaryColor),
    );
  }
}
