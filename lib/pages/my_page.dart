import 'package:flutter/material.dart';
import 'package:learning_app/widget/hi_webview.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的')),
      body: const HiWebView(
        url: 'http://www.lijianan.com',
        hideAppBar: true,
        satusBarColor: 'ffffff',
        title: '我的',
      ),
    );
  }
}
