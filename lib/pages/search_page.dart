import 'package:flutter/material.dart';
import 'package:learning_app/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(title: Text('搜索')),
      body: Column(
        children: [
          SearchBarWidget(searchBarType: SearchBarType.home, hintText: '请输入搜索内容'),
          SearchBarWidget(searchBarType: SearchBarType.homeLight, hintText: '请输入搜索内容'),
          SearchBarWidget(searchBarType: SearchBarType.normal, hintText: '请输入搜索内容'),
        ],
      ),
    );
  }
}
