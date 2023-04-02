import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'utilities/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.white,
        ),
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      // home: WelcomePage(),
      home: WelcomePage(),
    );
  }
}
