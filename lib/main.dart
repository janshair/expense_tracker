import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/transactions_and_chart.dart';

void main() =>   runApp(MyApp());
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var primary = Colors.green;
  var accent = Colors.blue;
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
          primarySwatch: primary,
          accentColor: accent,
          fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                  )))),
      home: MyHomePage(),
      // routes: {'/': (context) => LoginWidget()},
    );
  }
}
