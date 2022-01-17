import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/providers/progress_indicator.dart';
import 'package:todo/providers/todo_provider.dart';

progressIndicator(calculateProgress, context) {
  return Consumer<IndicatorProvider>(
    builder: (context, indicatorData, child) => Consumer<TodoProvider>(
        builder: (context, data, child) => data.taskList.isEmpty
            ? const SizedBox()
            : indicatorData.showIndicator == false
                ? const SizedBox()
                : SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.13,
                    child: SleekCircularSlider(
                      min: 0,
                      max: 100,
                      appearance: const CircularSliderAppearance(
                        size: 50,
                      ),
                      initialValue: calculateProgress(data),
                      innerWidget: (dbl) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            textWidget(
                                data.taskList.isEmpty
                                    ? ''
                                    : data.taskList.length == 1
                                        ? '1 task'
                                        : '${data.taskList.length} tasks',
                                16.0,
                                Colors.white),
                            textWidget(
                                dbl.toString().substring(0, 3) == '100'
                                    ? '100%'
                                    : dbl.toString().length == 3
                                        ? '0%'
                                        : dbl.toString().substring(0, 2) + '%',
                                30.0,
                                Colors.white)
                          ],
                        );
                      },
                    ),
                  )),
  );
}
