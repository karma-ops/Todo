import 'package:flutter/material.dart';

settingsIcon(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.05,
    child: Align(
      alignment: Alignment.centerRight,
      child: Tooltip(
        message: 'Settings',
        child: IconButton(
            splashRadius: 25.0,
            onPressed: () {
              Navigator.pushNamed(context, 'settings');
            },
            icon: const Icon(Icons.settings, color: Colors.white)),
      ),
    ),
  );
}
