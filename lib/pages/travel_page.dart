import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/controller/travel_controller.dart';
import 'package:learning_app/pages/travel_tab_page.dart';

class TravelPage extends StatelessWidget {
  const TravelPage({super.key});

  Widget get _tabBar {
    return GetBuilder<TravelController>(
      builder: (controller) {
        return TabBar(
          controller: controller.tabController,
          isScrollable: true,
          labelColor: Colors.black,
          indicatorColor: Color(0xff2fcfbb),
          tabAlignment: TabAlignment.start,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: controller.tabs.map<Tab>((tab) {
            return Tab(text: tab.labelName);
          }).toList(),
        );
      },
    );
  }

  Widget get _tabBarView {
    return GetBuilder<TravelController>(
      builder: (controller) {
        return TabBarView(
          controller: controller.tabController,
          children: controller.tabs.map((tab) {
            return TravelTabPage(groupChannelCode: tab.groupChannelCode);
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TravelController());
    final top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
            child: _tabBar,
          ),
          Expanded(child: _tabBarView),
        ],
      ),
    );
  }
}
