import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learning_app/pages/home_page.dart';
import 'package:learning_app/pages/login_page.dart';
import 'package:learning_app/widget/hi_webview.dart';

class NavigatorUtil {
  static BuildContext? _context;
  static void updateContext(BuildContext context) {
    NavigatorUtil._context = context;
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

  // 返回上一页
  static void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      // 如果没有上一页，则退出应用
      SystemNavigator.pop();
    }
  }

  // 跳转到 h5 页面
  static void jumpH5({
    BuildContext? context,
    String? url,
    String? title,
    bool? hideAppBar,
    String? statusBarColor,
  }) {
    BuildContext? safeContext;
    if (url == null || url.isEmpty) {
      return;
    }
    if (context != null) {
      safeContext = context;
    } else if (_context?.mounted ?? false) {
      safeContext = _context;
    } else {
      return;
    }
    Navigator.push(
      safeContext!,
      MaterialPageRoute(
        builder: (context) => HiWebView(
          url: url,
          title: title,
          hideAppBar: hideAppBar,
          satusBarColor: statusBarColor,
        ),
      ),
    );
  }
}
