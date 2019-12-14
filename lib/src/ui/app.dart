import 'package:flutter/material.dart';
import 'package:flutter_sample_oauth/src/injector/injector.dart';
import 'package:flutter_sample_oauth/src/storage/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_sample_oauth/src/ui/dashboarduser/dashboard_user_screen.dart';
import 'package:flutter_sample_oauth/src/ui/login/login_screen.dart';
import 'package:flutter_sample_oauth/src/ui/register/register_screen.dart';

class App extends StatelessWidget {
  SharedPreferencesManager _sharedPreferencesManager = locator<SharedPreferencesManager>();
  bool _isAlreadyLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    _isAlreadyLoggedIn = _sharedPreferencesManager.isKeyExists(SharedPreferencesManager.keyIsLogin)
        ? _sharedPreferencesManager.getBool(SharedPreferencesManager.keyIsLogin)
        : false;

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFF06038),
      ),
      home: _isAlreadyLoggedIn ? DashboardUserScreen() : LoginScreen(),
      routes: {
        '/login_screen': (context) => LoginScreen(),
        '/register_screen': (context) => RegisterScreen(),
        '/dashboard_user_screen': (context) => DashboardUserScreen(),
      },
    );
  }
}
