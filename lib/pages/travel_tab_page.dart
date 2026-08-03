import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:learning_app/dao/travel_dao.dart';
import 'package:learning_app/model/travel_tab_model.dart';
import 'package:learning_app/widget/travel_item_widget.dart';

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
  final ScrollController _scrollController = ScrollController();

  Widget get _gridView => MasonryGridView.count(
    controller: _scrollController,
    crossAxisCount: 2,
    itemCount: travelItems.length,
    itemBuilder: (BuildContext context, int index) {
      return TravelItemWidget(index: index, item: travelItems[index]);
    },
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _gridView);
  }

  Future<void> _loadData({bool loadMore = false}) async {
    try {
      final model = await TravelDao.getTravels(widget.groupChannelCode, pageIndex, 10);
      final items = _filterItems(model?.data.list ?? []);
      if (!mounted) {
        return;
      }
      setState(() {
        if (loadMore) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
        isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        isLoading = false;
      });
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
