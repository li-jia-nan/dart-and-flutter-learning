import 'package:flutter/material.dart';
import 'package:learning_app/dao/login_dao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  Widget get _loginBtn => ElevatedButton(
    onPressed: () {
      LoginDao.logOut();
    },
    child: const Text('退出'),
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('首页', style: TextStyle(color: Colors.white)),
        actions: [_loginBtn],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
