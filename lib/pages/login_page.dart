import 'package:flutter/material.dart';
import 'package:learning_app/utils/view_util.dart';

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
        ],
      ),
    );
  }
}
