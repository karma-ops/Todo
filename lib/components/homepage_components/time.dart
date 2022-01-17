import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/providers/time_provider.dart';

// homepage time of the top

SizedBox time(firstTime, context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.12,
    child: Consumer<TimeProvider>(
      builder: (context, data, child) {
        return data.timeString == ''
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: textWidget(
                          firstTime.substring(10, 19), 35.0, Colors.white)),
                  Center(
                      child: textWidget(
                          firstTime.substring(0, 10), 14.0, Colors.white)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: textWidget(data.timeString.substring(10, 19), 35.0,
                          Colors.white)),
                  Center(
                      child: textWidget(data.timeString.substring(0, 10), 14.0,
                          Colors.white)),
                ],
              );
      },
    ),
  );
}
