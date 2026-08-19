import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/mvvm/login/controllers/controller.dart';
import 'package:learning_app/utils/view_util.dart';
import 'package:learning_app/widget/input_widget.dart';
import 'package:learning_app/widget/login_widget.dart';

// 登录页
class LoginPage extends GetView<LoginViewModel> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // 避免键盘弹出时导致布局跳动
      body: Stack(children: [..._background(), _content()]),
    );
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
            onChanged: (text) => controller.onValueChanged(text, LoginInputType.username),
          ),
          hiSpace(height: 10),
          InputWidget(
            '请输入密码',
            obscureText: true,
            onChanged: (text) => controller.onValueChanged(text, LoginInputType.password),
          ),
          hiSpace(height: 45),
          Obx(
            () => LoginButton(
              '登录',
              enable: controller.loginEnabled.value,
              onPressed: controller.login,
            ),
          ),
          hiSpace(height: 15),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: controller.jumpToRegister,
              child: const Text('注册帐号', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
