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

// 下拉刷新和上拉加载更多
class RefreshLoadmorePage extends StatefulWidget {
  const RefreshLoadmorePage({super.key});

  @override
  State<RefreshLoadmorePage> createState() => _RefreshLoadmorePageState();
}

class _RefreshLoadmorePageState extends State<RefreshLoadmorePage> {
  final ScrollController _scrollController = ScrollController();

  List<String> cityNames = [
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

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // 到达底部，加载更多数据
        _loadMoreData();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const title = '下拉刷新和上拉加载更多';
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: const Text(title)),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(controller: _scrollController, children: _buildList()),
        ),
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
      // alignment: Alignment.center,
      decoration: const BoxDecoration(color: Colors.redAccent),
      child: Text(city, style: const TextStyle(color: Colors.white, fontSize: 20)),
    );
  }

  Future<void> _handleRefresh() async {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        cityNames = cityNames.reversed.toList();
      });
    });
  }

  Future<void> _loadMoreData() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        cityNames.addAll(['新城市1', '新城市2', '新城市3', '新城市4', '新城市5']);
      });
    });
  }
}
