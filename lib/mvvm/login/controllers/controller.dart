import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/dao/login_dao.dart';
import 'package:learning_app/utils/navigator_util.dart';
import 'package:url_launcher/url_launcher.dart';

enum LoginInputType { username, password }

class LoginViewModel extends GetxController {
  final loginEnabled = false.obs;
  String username = '';
  String password = '';

  void onValueChanged(String value, LoginInputType type) {
    if (type == LoginInputType.username) {
      username = value;
    } else {
      password = value;
    }
    loginEnabled.value =
        username != null && username.isNotEmpty && password != null && password.isNotEmpty;
  }

  final PageController controller = PageController(initialPage: 0);

  Future<void> login() async {
    try {
      await LoginDao.login(userName: username, password: password);
      debugPrint('登录成功');
      NavigatorUtil.goToHome();
    } catch (e) {
      NavigatorUtil.goToHome();
    }
  }

  Future<void> jumpToRegister() async {
    Uri uri = Uri.parse('https://www.baidu.com');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
