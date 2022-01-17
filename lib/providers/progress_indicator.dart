import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences _prefs;

class IndicatorProvider extends ChangeNotifier {
  bool _showIndicator = true;

  bool get showIndicator => _showIndicator;

  getIndicatorValue() async {
    _prefs = await SharedPreferences.getInstance();
    var boolValue = _prefs.getString('progressIndicator');
    var newValue = true;
    if (boolValue == 'true') {
      newValue = true;
    } else if (boolValue == 'false') {
      newValue = false;
    } else {
      newValue = true;
    }
    _showIndicator = newValue;
    notifyListeners();
  }

  changeIndicator(boolean) async {
    _showIndicator = boolean;
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString('progressIndicator', _showIndicator.toString());
    notifyListeners();
  }
}
