import 'package:flutter/material.dart';
import 'package:learning_app/dao/login_dao.dart';
import 'package:learning_app/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  final List<String> bannerList = [
    'https://gw.alipayobjects.com/zos/basement_prod/048ee28f-2c80-4d15-9aa3-4f5ddac50465.svg',
    'https://gw.alipayobjects.com/zos/basement_prod/5edc7f4d-3302-4710-963b-7b6c77ea8d06.svg',
    'https://gw.alipayobjects.com/zos/basement_prod/a9dc586a-fe0a-4c7d-ab4f-f5ed779b963d.svg',
    'https://gw.alipayobjects.com/zos/basement_prod/c0c3852c-d245-4330-886b-cb02ef49eb6d.svg',
  ];

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
      body: Column(children: [BannerWidget(bannerList: bannerList)]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
