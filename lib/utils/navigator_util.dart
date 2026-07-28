import 'package:flutter/material.dart';
import 'package:learning_app/pages/home_page.dart';
import 'package:learning_app/pages/login_page.dart';

class NavigatorUtil {
  static BuildContext? _context;
  static void updateContext(BuildContext context) {
    NavigatorUtil._context = context;
    print('NavigatorUtil context updated: $_context');
  }

  // 跳转到指定页面
  static void push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  // 跳转到首页
  static void goToHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (cntext) => const HomePage()));
  }

  // 跳转到登录页
  static void goToLogin() {
    Navigator.pushReplacement(
      _context!,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}
