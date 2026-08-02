import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learning_app/dao/travel_dao.dart';
import 'package:learning_app/model/travel-category-model.dart';

class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  List<TravelTab> tabs = [];
  TravelCategoryModel? travelTabModel;

  @override
  void initState() {
    super.initState();
    TravelDao.getCategory().then((TravelCategoryModel? model) {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('旅拍')),
      body: Column(children: [Text(jsonEncode(travelTabModel))]),
    );
  }
}
