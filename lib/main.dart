import 'package:flutter/material.dart';
import 'package:flutter_sample_oauth/src/injector/injector.dart';
import 'package:flutter_sample_oauth/src/ui/app.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    runApp(App());
  } catch (error, stacktrace) {
    print('$error & $stacktrace');
  }
}
