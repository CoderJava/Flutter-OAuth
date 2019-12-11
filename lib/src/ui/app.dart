import 'package:flutter/material.dart';
import 'package:flutter_sample_oauth/src/ui/login/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFF06038),
      ),
      home: LoginScreen(),
    );
  }
}
