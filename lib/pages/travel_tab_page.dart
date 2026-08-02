import 'package:flutter/material.dart';

// 旅拍列表页
class TravelTabPage extends StatefulWidget {
  final String groupChannelCode;
  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [Text('groupChannelCode: ${widget.groupChannelCode}')]));
  }
}
