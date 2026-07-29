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
    'https://gw.alipayobjects.com/mdn/rms_08e378/afts/img/A*KKZWRozT8D8AAAAAAAAAAABkARQnAQ',
    'https://gw.alipayobjects.com/mdn/rms_08e378/afts/img/A*yB0oQ42f0kEAAAAAAAAAAABkARQnAQ',
    'https://gw.alipayobjects.com/mdn/rms_08e378/afts/img/A*aFAfTKIjR_IAAAAAAAAAAABkARQnAQ',
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
