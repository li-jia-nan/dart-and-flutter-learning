import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/dao/travel_dao.dart';
import 'package:learning_app/model/travel_tab_model.dart';

class TravelTabController extends GetxController {
  final String groupChannelCode;

  TravelTabController({required this.groupChannelCode});

  final travelItems = <TravelItem>[].obs;
  final isLoading = true.obs;
  int pageIndex = 1;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    loadData();
    scrollController.addListener(() {
      if (!scrollController.hasClients) {
        return;
      }
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
        // 到达底部，加载更多数据
        loadData(loadMore: true);
      }
    });
  }

  @override
  void onClose() {
    // 将滚动控制器的监听器移除，避免内存泄漏
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadData({bool loadMore = false}) async {
    if (loadMore) {
      pageIndex++;
    } else {
      pageIndex = 1;
    }
    try {
      TravelTabModel? model = await TravelDao.getTravels(groupChannelCode, pageIndex, 10);
      final items = _filterItems(model?.data.list ?? []);
      if (loadMore && items.isEmpty) {
        pageIndex--;
      }
      if (!loadMore) {
        travelItems.clear();
      }
      travelItems.addAll(items);
      isLoading.value = false;
    } catch (error) {
      pageIndex--;
      isLoading.value = false;
    }
  }

  List<TravelItem> _filterItems(List<TravelItem>? list) {
    if (list == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    for (var item in list) {
      if (item.article.articleId != null) {
        filterItems.add(item);
      }
    }
    return filterItems;
  }
}
