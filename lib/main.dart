import 'package:awesome/pages/DashboardPage.dart';
import 'package:awesome/utils/injector.dart';
import 'package:flutter/material.dart';

import 'constants/Constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  await baseDio();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      home: DashboardPage(),
      initialRoute: '/',
      routes: {
        '/login': (context) => DashboardPage(),
        // '/home': (context) => HomePage(),
      },
      theme: ThemeData(
        appBarTheme:
        AppBarTheme(color: Color(Constants.appMainColor), elevation: 0),
        primaryColor: Color(Constants.appMainColor),
        primaryColorDark: Color(Constants.appMainColor),
        accentColor: Color(0xFFe0e0e0),
        backgroundColor: Constants.appBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
