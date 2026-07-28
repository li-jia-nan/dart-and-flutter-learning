import 'package:flutter/material.dart';
import 'package:learning_app/dao/login_dao.dart';
import 'package:learning_app/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget get _loginBtn => ElevatedButton(
    onPressed: () {
      LoginDao.logOut();
    },
    child: const Text('退出'),
  );

  @override
  Widget build(BuildContext context) {
    NavigatorUtil.updateContext(context);
    return Scaffold(
      appBar: AppBar(title: const Text('首页'), actions: [_loginBtn]),
    );
  }
}
