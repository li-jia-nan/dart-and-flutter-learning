import 'package:flutter/material.dart';
import 'package:learning_app/dao/login_dao.dart';
import 'package:learning_app/utils/string_util.dart';
import 'package:learning_app/utils/view_util.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:learning_app/widget/input_widget.dart';
import 'package:learning_app/widget/login_widget.dart';

// 登录页
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginEnable = false;
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Stack(children: [..._background(), _content()]));
  }

  List<Widget> _background() {
    return [
      Positioned.fill(child: Image.asset('images/result-modal-bg.webp', fit: BoxFit.cover)),
      Positioned.fill(
        child: Container(decoration: const BoxDecoration(color: Colors.black54)),
      ),
    ];
  }

  Widget _content() {
    return Positioned.fill(
      left: 25,
      right: 25,
      child: ListView(
        children: [
          hiSpace(height: 100),
          const Text('账号密码登录', style: TextStyle(fontSize: 26, color: Colors.white)),
          hiSpace(height: 40),
          InputWidget(
            '请输入账号',
            onChanged: (text) {
              username = text;
              _checkInput();
            },
          ),
          hiSpace(height: 10),
          InputWidget(
            '请输入密码',
            obscureText: true,
            onChanged: (text) {
              password = text;
              _checkInput();
            },
          ),
          hiSpace(height: 45),
          LoginButton('登录', enable: loginEnable, onPressed: _login),
          hiSpace(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: _jumpToRegister,
              child: const Text('注册帐号', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }

  void _checkInput() {
    bool enable;
    if (isNotEmpty(username) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void _login() {
    try {
      var result = LoginDao.login(userName: username!, password: password!);
      debugPrint('登录结果: $result');
    } catch (e) {
      debugPrint('登录异常: $e');
    }
  }

  Future<void> _jumpToRegister() async {
    Uri uri = Uri.parse('https://www.baidu.com');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
