import 'package:flutter/material.dart';
import 'package:learning_app/dao/login_dao.dart';
import 'package:learning_app/widget/banner_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  static const int appBarScrollOffset = 100;

  final List<String> bannerList = [
    'https://images.unsplash.com/photo-1498050108023-c5249f4df085?auto=format&fit=crop&w=1200&h=480&q=80',
    'https://images.unsplash.com/photo-1519389950473-47ba0277781c?auto=format&fit=crop&w=1200&h=480&q=80',
    'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=1200&h=480&q=80',
    'https://images.unsplash.com/photo-1558082303-0e7e9bba6e47?auto=format&fit=crop&w=1200&h=480&q=80',
    'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?auto=format&fit=crop&w=1200&h=480&q=80',
  ];

  double appBarAlpha = 0;

  Widget get _loginBtn => ElevatedButton(
    onPressed: () {
      LoginDao.logOut();
    },
    child: const Text('退出'),
  );

  Widget get _appBar => Opacity(
    opacity: appBarAlpha,
    child: Container(
      height: 80,
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Padding(padding: EdgeInsets.only(top: 20), child: Text('首页')),
      ),
    ),
  );

  Widget get _listView => ListView(
    children: [
      BannerWidget(bannerList: bannerList),
      _loginBtn,
      const SizedBox(height: 800, child: ListTile(title: Text('哈哈'))),
    ],
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true, // 移除顶部安全区
            context: context,
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is ScrollUpdateNotification && notification.depth == 0) {
                  // 通过 depth == 0 来判断是 ListView 滚动，而不是内部其他可滚动组件的滚动
                  _onScroll(notification.metrics.pixels);
                }
                return false;
              },
              child: _listView,
            ),
          ),
          _appBar,
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onScroll(double offset) {
    double alpha = offset / appBarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }
}
