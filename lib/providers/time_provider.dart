import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _prefs;

class TimeProvider extends ChangeNotifier {
  bool _showTimer = true;
  bool get showTimer => _showTimer;

  String _timeString = '';

  String get timeString => _timeString;

  getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    _timeString = formattedDateTime;
    notifyListeners();
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('MM/dd/yyyy HH:mm:ss').format(dateTime);
  }

  getTimerValue() async {
    _prefs = await SharedPreferences.getInstance();
    var boolValue = _prefs.getString('showTimer');
    var newValue = true;
    if (boolValue == 'true') {
      newValue = true;
    } else if (boolValue == 'false') {
      newValue = false;
    } else {
      newValue = true;
    }
    _showTimer = newValue;
    notifyListeners();
  }

  changeTimeShowIndicator(boolean) async {
    _showTimer = boolean;
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString('showTimer', _showTimer.toString());
    notifyListeners();
  }
}
