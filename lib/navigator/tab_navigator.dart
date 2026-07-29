// 首页底部导航栏
import 'package:flutter/material.dart';
import 'package:learning_app/pages/home_page.dart';
import 'package:learning_app/pages/my_page.dart';
import 'package:learning_app/pages/search_page.dart';
import 'package:learning_app/pages/travel_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),
    );
  }
}
