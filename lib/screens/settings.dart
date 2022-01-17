import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/components.dart';
import 'package:todo/components/constants_and_variables.dart';
import 'package:todo/providers/progress_indicator.dart';
import 'package:todo/providers/time_provider.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryColor,
        body: SafeArea(
            child: Stack(
          children: [
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: AppBar(
                // backwardsCompatibility: false,
                leading: Tooltip(
                  message: "Go back",
                  child: IconButton(
                    splashRadius: 25.0,
                    icon:
                        const Icon(Icons.arrow_back_sharp, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                backgroundColor:
                    Colors.transparent, //You can make this transparent
                elevation: 0.0, //No shadow
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  Consumer<IndicatorProvider>(
                    builder: (context, data, child) => SwitchListTile(
                      selectedTileColor: Colors.red,
                      inactiveTrackColor: Colors.grey,
                      activeColor: Colors.orange.shade400,
                      value: data.showIndicator,
                      onChanged: (boolean) {
                        Provider.of<IndicatorProvider>(context, listen: false)
                            .changeIndicator(boolean);
                      },
                      title: textWidget(
                          'Show progress indicator', 16.0, Colors.white),
                    ),
                  ),
                  Consumer<TimeProvider>(
                    builder: (context, data, child) => SwitchListTile(
                      selectedTileColor: Colors.red,
                      inactiveTrackColor: Colors.grey,
                      activeColor: Colors.orange.shade400,
                      value: data.showTimer,
                      onChanged: (boolean) {
                        Provider.of<TimeProvider>(context, listen: false)
                            .changeTimeShowIndicator(boolean);
                      },
                      title: textWidget('Show time', 16.0, Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
