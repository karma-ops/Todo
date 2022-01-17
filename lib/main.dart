import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/components/constants_and_variables.dart';
import 'package:todo/providers/progress_indicator.dart';
import 'package:todo/providers/time_provider.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/screens/detail.dart';
import 'package:todo/screens/home.dart';
import 'package:todo/screens/settings.dart';
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => TodoProvider()),
    ChangeNotifierProvider(create: (context) => TimeProvider()),
    ChangeNotifierProvider(create: (context) => IndicatorProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: kPrimaryColor, fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        'detail': (context) => Detail(),
        'settings': (context) => const Settings()
      },
    );
  }
}
