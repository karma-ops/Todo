import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/components/constants_and_variables.dart';
import 'package:todo/components/detail_components/detail_appbar.dart';
import 'package:todo/components/detail_components/detail_form.dart';
import 'package:todo/components/detail_components/discard_dialog.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:timezone/timezone.dart' as tz;

// ignore: must_be_immutable
class Detail extends StatefulWidget {
  Detail({Key? key, this.taskIndex}) : super(key: key);
  int? taskIndex;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _subtitleController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool? discardChanges = false;

  late FlutterLocalNotificationsPlugin remindNotification =
      FlutterLocalNotificationsPlugin();

  void _saveForm() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
  }

  final snackBar = SnackBar(
    padding: const EdgeInsets.only(top: 20, bottom: 18, left: 20),
    content: const Text('Task saved successfully'),
    backgroundColor: Colors.blueGrey.shade800,
    duration: const Duration(milliseconds: 1500),
  );

  @override
  void initState() {
    super.initState();

    var androidInitialize = const AndroidInitializationSettings('notification');
    const IOSInitializationSettings iosInitialize = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    var initializationSettings =
        InitializationSettings(android: androidInitialize, iOS: iosInitialize);

    remindNotification = FlutterLocalNotificationsPlugin();
    remindNotification.initialize(
      initializationSettings,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  Future showNotification(
      seconds, minutes, hours, reminderType, periodicTime, id) async {
    const sound = "notification_sound.wav";
    var todoProvider = Provider.of<TodoProvider>(context, listen: false);
    var androidDetails = AndroidNotificationDetails(
      'Channel id 1',
      'Todo',
      channelDescription: 'Channel for todo',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(sound.split('.').first),
    );
    var iosDetails = const IOSNotificationDetails(sound: sound);
    var notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    var scheduledTime = DateTime.now().add(Duration(
        seconds: int.parse(seconds),
        minutes: int.parse(minutes),
        hours: int.parse(hours)));
    if (reminderType == 'scheduled') {
      await remindNotification.zonedSchedule(
          widget.taskIndex!,
          'Task Reminder: ${todoProvider.taskList[widget.taskIndex!].title}',
          '${todoProvider.taskList[widget.taskIndex!].subTitle}',
          tz.TZDateTime.from(scheduledTime, tz.local),
          notificationDetails,
          androidAllowWhileIdle: false,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: widget.taskIndex.toString());
    } else {
      var repeatInterval = RepeatInterval.everyMinute;
      if (periodicTime == 'Every Minute') {
        repeatInterval = RepeatInterval.everyMinute;
      } else if (periodicTime == 'Hourly') {
        repeatInterval = RepeatInterval.hourly;
      } else if (periodicTime == 'Daily') {
        repeatInterval = RepeatInterval.daily;
      } else {
        repeatInterval = RepeatInterval.weekly;
      }
      await remindNotification.periodicallyShow(
          widget.taskIndex!,
          'Task Reminder: ${todoProvider.taskList[widget.taskIndex!].title}',
          '${todoProvider.taskList[widget.taskIndex!].subTitle}',
          repeatInterval,
          notificationDetails,
          androidAllowWhileIdle: false,
          payload: widget.taskIndex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as Map;
    widget.taskIndex = arguments['taskIndex'];
    _titleController.text =
        '${Provider.of<TodoProvider>(context, listen: false).taskList[widget.taskIndex!].title}';
    _subtitleController.text =
        '${Provider.of<TodoProvider>(context, listen: false).taskList[widget.taskIndex!].subTitle}';

    return WillPopScope(
      onWillPop: () async {
        // print('gone back');
        return willPopScope(
            _titleController, _subtitleController, context, widget);
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
          child: Stack(children: [
            appBar(context, _titleController, _subtitleController, widget,
                alertDialogDiscard),
            form(
                _formKey,
                context,
                _titleController,
                _subtitleController,
                widget,
                showNotification,
                _saveForm,
                snackBar,
                remindNotification),
          ]),
        ),
      ),
    );
  }
}
