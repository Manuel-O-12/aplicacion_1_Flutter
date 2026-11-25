import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/screen_login.dart';
import 'package:flutter_application_1/screens/screen_register.dart';
import 'package:flutter_application_1/screens/screen_home.dart';
import 'package:flutter_application_1/screens/screen_detail.dart';
import 'package:flutter_application_1/screens/screen_form.dart';
import 'package:flutter_application_1/screens/screen_ventas.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String form = '/form';
  static const String ventas = '/ventas';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const ScreenLogin(),
      register: (context) => const ScreenRegister(),
      home: (context) => const ScreenHome(),
      detail: (context) => const ScreenDetail(),
      form: (context) => const ScreenForm(),
      ventas: (context) => const ScreenVentas(),
    };
  }
}
