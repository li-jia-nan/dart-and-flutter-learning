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
    'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=1200&h=480&q=80',
    'https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=1200&h=480&q=80',
    'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=1200&h=480&q=80',
    'https://images.unsplash.com/photo-1558082303-0e7e9bba6e47?auto=format&fit=crop&w=1200&h=480&q=80',
    'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?auto=format&fit=crop&w=1200&h=480&q=80',
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
