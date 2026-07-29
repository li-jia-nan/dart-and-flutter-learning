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
        body: ListView.separated(
          itemCount: cityNames.length,
          itemBuilder: (context, index) => _item(cityNames[index]),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
        ),
      ),
    );
  }

  Widget _item(String city) {
    return Container(
      height: 80,
      alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.amber),
      child: Text(city, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }
}
