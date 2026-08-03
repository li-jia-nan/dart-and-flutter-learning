import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_app/dao/travel_dao.dart';
import 'package:learning_app/model/travel_tab_model.dart';

// 旅拍列表页
class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;
  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool isLoading = true;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text('travelItems: ${jsonEncode(travelItems)}')]));
  }

  void _loadData({bool loadMore = false}) {
    TravelDao.getTravels(widget.groupChannelCode, pageIndex, 10)
        .then((model) {
          List<TravelItem> items = _filterItems(model?.data.list ?? []);
          setState(() {
            if (loadMore) {
              travelItems.addAll(items);
            } else {
              travelItems = items;
            }
            isLoading = false;
          });
        })
        .catchError((e) {
          setState(() {
            isLoading = false;
          });
        });
  }

  List<TravelItem> _filterItems(List<TravelItem>? list) {
    if (list == null) {
      return [];
    }
    List<TravelItem> filterItems = [];
    for (var item in list) {
      if (item.article.isNotEmpty) {
        filterItems.add(item);
      }
    }
    return filterItems;
  }
}
