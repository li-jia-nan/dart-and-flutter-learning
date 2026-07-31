import 'package:flutter/material.dart';
import 'package:learning_app/dao/login_dao.dart';
import 'package:learning_app/dao/home_dao.dart';
import 'package:learning_app/loading_container.dart';
import 'package:learning_app/model/home_model.dart';
import 'package:learning_app/widget/banner_widget.dart';
import 'package:learning_app/widget/grid_nav_widget.dart';
import 'package:learning_app/widget/local_nav_widget.dart';
import 'package:learning_app/widget/sales_box_widget.dart';
import 'package:learning_app/widget/sub_nav_widget.dart';

class HomePage extends StatefulWidget {
  static Config? configModel;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  static const int appBarScrollOffset = 100;

  double appBarAlpha = 0;

  List<BannerList> bannerList = [];
  List<LocalNavList> localNavList = [];
  List<LocalNavList> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;

  bool _isLoading = true;

  Widget get _loginBtn => ElevatedButton(
    onPressed: () {
      LoginDao.logOut();
    },
    child: const Text('退出'),
  );

  Widget get _appBar => Opacity(
    opacity: appBarAlpha,
    child: Container(
      padding: const EdgeInsets.only(top: 20),
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
      LocalNavWidget(localNavList: localNavList),
      if (gridNavModel != null) GridNavWidget(gridNavModel: gridNavModel!),
      SubNavWidget(subNavList: subNavList),
      if (salesBoxModel != null) SalesBoxWidget(salesBox: salesBoxModel!),
      _loginBtn,
      const SizedBox(height: 800, child: ListTile(title: Text('哈哈'))),
    ],
  );

  Widget get _containerView => MediaQuery.removePadding(
    removeTop: true, // 移除顶部安全区
    context: context,
    child: RefreshIndicator(
      color: Colors.blue,
      onRefresh: _handleRefresh,
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
  );

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
        isLoading: _isLoading,
        cover: true,
        child: Stack(children: [_containerView, _appBar]),
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

  Data? homeData;

  Future<void> _handleRefresh() async {
    try {
      Data? model = await HomeDao.fetch();
      if (!mounted) {
        return;
      }
      setState(() {
        HomePage.configModel = model?.config;
        localNavList = model?.localNavList ?? [];
        subNavList = model?.subNavList ?? [];
        gridNavModel = model?.gridNav;
        salesBoxModel = model?.salesBox;
        bannerList = model?.bannerList ?? [];
        _isLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }
}
