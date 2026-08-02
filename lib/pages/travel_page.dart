import 'package:flutter/material.dart';
import 'package:learning_app/dao/travel_dao.dart';
import 'package:learning_app/model/travel-category-model.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin {
  List<TravelTab> tabs = [];
  TravelCategoryModel? travelTabModel;
  late TabController? _tabController;

  Widget get _tabBar => TabBar(
    controller: _tabController,
    isScrollable: true,
    labelColor: Colors.black,
    indicatorColor: Color(0xff2fcfbb),
    tabAlignment: TabAlignment.start,
    indicatorSize: TabBarIndicatorSize.tab,
    tabs: tabs.map<Tab>((tab) {
      return Tab(text: tab.labelName);
    }).toList(),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    TravelDao.getCategory().then((TravelCategoryModel? model) {
      _tabController = TabController(length: model?.data.tabs.length ?? 0, vsync: this);
      if (!mounted) {
        return;
      }
      setState(() {
        tabs = model?.data.tabs ?? [];
        travelTabModel = model;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
            child: _tabBar,
          ),
        ],
      ),
    );
  }
}
