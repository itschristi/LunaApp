// @dart=2.9

import 'package:flutter/material.dart';
import 'package:luna/screen/NavigationScreen.dart';
import 'package:luna/screen/WelcomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luna',
        theme: ThemeData(fontFamily: 'Ubuntu'),
        debugShowCheckedModeBanner: false,
        initialRoute: NavigationScreen.id,
        routes: {
          NavigationScreen.id: (context) => NavigationScreen(),
        }
        // NavigationScreen.id: (context) => NavigationScreen(),
    );
  }
}
