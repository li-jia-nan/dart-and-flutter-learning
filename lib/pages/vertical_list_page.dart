import 'package:flutter/material.dart';

const List<String> cityNames = [
  '北京',
  '上海',
  '广州',
  '深圳',
  '杭州',
  '成都',
  '重庆',
  '武汉',
  '西安',
  '南京',
  '天津',
  '苏州',
  '青岛',
  '大连',
  '厦门',
  '福州',
  '济南',
  '沈阳',
  '哈尔滨',
  '长春',
];

// 垂直滚动的列表
class VerticalListPage extends StatelessWidget {
  const VerticalListPage({super.key});

  @override
  Widget build(BuildContext context) {
    const title = '垂直滚动';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: ListView(children: _buildList()),
      ),
    );
  }

  List<Widget> _buildList() {
    return cityNames.map((city) => _item(city)).toList();
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 5),
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Text(city, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
