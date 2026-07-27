import 'dart:convert';
import 'package:flutter/material.dart';

class JsonParsingPage extends StatefulWidget {
  const JsonParsingPage({super.key});

  @override
  State<JsonParsingPage> createState() => _JsonParsingPageState();
}

class _JsonParsingPageState extends State<JsonParsingPage> {
  var resultShow = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSON Parsing 应用实战')),
      body: Column(children: [_json2MapBtn(), Text('解析的结果：$resultShow')]),
    );
  }

  Widget _json2MapBtn() {
    return ElevatedButton(onPressed: _json2MapClick, child: const Text('JSON 转 Map'));
  }

  void _json2MapClick() {
    const jsonString = '{"name": "张三", "age": 18, "gender": "男"}';
    Map<String, dynamic> map = jsonDecode(jsonString);
    setState(() {
      resultShow = '姓名：${map['name']}, 年龄：${map['age']}, 性别：${map['gender']}';
    });
  }
}
