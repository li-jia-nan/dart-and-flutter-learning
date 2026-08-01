import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learning_app/dao/search_dao.dart';
import 'package:learning_app/model/search_model.dart';
import 'package:learning_app/utils/navigator_util.dart';
import 'package:learning_app/utils/view_util.dart';
import 'package:learning_app/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String? keyword;
  final String? hint;

  const SearchPage({super.key, this.hideLeft, this.keyword, this.hint});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel? searchModel;
  String? keyword = '';

  @override
  void initState() {
    super.initState();
  }

  Widget get _appBar {
    // 获取刘海屏实际高度
    double top = MediaQuery.of(context).padding.top;
    return shadowWarp(
      child: Container(
        height: 55 + top,
        decoration: BoxDecoration(color: Colors.white),
        padding: const EdgeInsets.only(bottom: 5),
        child: SearchBarWidget(
          hideLeft: widget.hideLeft,
          defaultText: widget.keyword,
          hintText: widget.hint,
          leftButtonClick: () => NavigatorUtil.pop(context),
          onChanged: _onTextChanged,
        ),
      ),
      padding: const EdgeInsets.only(bottom: 5),
    );
  }

  Widget get _listView => MediaQuery.removePadding(
    context: context,
    // removeTop: true,
    child: Expanded(
      child: ListView.builder(
        itemCount: searchModel?.data.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          return _item(index);
        },
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [_appBar, _listView]));
  }

  void _onTextChanged(String value) async {
    try {
      final result = await SearchDao.fetch(value);
      if (result == null) {
        return;
      }
      if (!mounted) {
        return;
      }
      setState(() {
        searchModel = result;
      });
    } catch (e) {
      //
    }
  }

  Widget _item(int index) {
    SearchItem item = searchModel.data[index];
    return Text(item.word);
  }
}
