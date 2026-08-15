import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/navigator/tab_navigator.dart';
import 'package:learning_app/pages/login_page.dart';
import 'package:learning_app/widget/hi_webview.dart';

class NavigatorUtil {
  // 跳转到指定页面
  static void push(BuildContext context, Widget page) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => page));
    Get.to(page);
  }

  // 跳转到首页
  static void goToHome(BuildContext context) {
    Get.offAll(const TabNavigator());
  }

  // 跳转到登录页
  static void goToLogin() {
    Get.offAll(const LoginPage());
  }

  // 返回上一页
  static void pop(BuildContext context) {
    Get.back();
  }

  // 跳转到 h5 页面
  static void jumpH5({
    BuildContext? context,
    String? url,
    String? title,
    bool? hideAppBar,
    String? statusBarColor,
  }) {
    if (url == null || url.isEmpty) {
      return;
    }
    Get.to(HiWebView(url: url, title: title, hideAppBar: false, satusBarColor: statusBarColor));
  }
}
