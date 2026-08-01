import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learning_app/dao/search_dao.dart';
import 'package:learning_app/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String showText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text('搜索')),
      body: ListView(
        children: [
          SearchBarWidget(
            hideLeft: true,
            defaultText: '网红打卡地 景点 酒店 美食',
            hintText: '请输入搜索内容',
            leftButtonClick: () {
              Navigator.pop(context);
            },
            onChanged: _onTextChanged,
          ),
          Text(showText),
        ],
      ),
    );
  }

  void _onTextChanged(String value) async {
    try {
      final result = await SearchDao.fetch(value);
      if (!mounted) {
        return;
      }
      setState(() {
        showText = jsonEncode(result);
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        showText = '搜索失败，请稍后重试';
      });
    }
  }
}
