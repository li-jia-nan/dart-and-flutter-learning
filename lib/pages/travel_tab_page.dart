import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:learning_app/controller/travel_tab_controller.dart';
import 'package:learning_app/loading_container.dart';
import 'package:learning_app/widget/travel_item_widget.dart';

// 旅拍列表页
class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;
  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> with AutomaticKeepAliveClientMixin {
  late TravelTabController _controller;

  Widget get _gridView => MasonryGridView.count(
    controller: _controller.scrollController,
    crossAxisCount: 2,
    itemCount: _controller.travelItems.length,
    itemBuilder: (BuildContext context, int index) {
      return TravelItemWidget(index: index, item: _controller.travelItems[index]);
    },
  );

  @override
  void initState() {
    super.initState();
    _controller = Get.put(
      TravelTabController(groupChannelCode: widget.groupChannelCode),
      tag: widget.groupChannelCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(body: _obx);
  }

  @override
  bool get wantKeepAlive => true;

  Widget get _obx => Obx(
    () => LoadingContainer(
      isLoading: _controller.isLoading.value,
      child: RefreshIndicator(
        color: Colors.blue,
        onRefresh: _handleRefresh,
        child: MediaQuery.removePadding(removeTop: true, context: context, child: _gridView),
      ),
    ),
  );

  // Widget get _getX => GetX<TravelTabController>(
  //   builder: (TravelTabController controller) => LoadingContainer(
  //     isLoading: controller.isLoading.value,
  //     child: RefreshIndicator(
  //       color: Colors.blue,
  //       onRefresh: _handleRefresh,
  //       child: MediaQuery.removePadding(removeTop: true, context: context, child: _gridView),
  //     ),
  //   ),
  //   init: _controller,
  // );

  Future<void> _handleRefresh() async {
    await _controller.loadData();
    return Future.value();
  }
}
