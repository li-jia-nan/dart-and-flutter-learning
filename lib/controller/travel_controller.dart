import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learning_app/dao/travel_dao.dart';
import 'package:learning_app/model/travel_category_model.dart';

class TravelController extends GetxController with GetTickerProviderStateMixin {
  List<TravelTab> tabs = [];
  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this);
    TravelDao.getCategory().then((TravelCategoryModel? model) {
      tabController = TabController(length: model?.data.tabs.length ?? 0, vsync: this);
      tabs = model?.data.tabs ?? [];
      update();
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
