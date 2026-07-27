import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpStudy extends StatefulWidget {
  const HttpStudy({super.key});

  @override
  State<HttpStudy> createState() => _HttpStudyState();
}

class _HttpStudyState extends State<HttpStudy> {
  var responseData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('基于 Http 实现网络操作 - Flutter 网络开发实战应用')),
      body: Column(
        children: [
          _doGetBtn(),
          _doPostBtn(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: SelectableText('HTTP 请求结果：$responseData'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _doGetBtn() {
    return ElevatedButton(onPressed: _doGetClick, child: const Text('发送 Http Get 请求'));
  }

  Widget _doPostBtn() {
    return ElevatedButton(onPressed: _doPostClick, child: const Text('发送 Http Post 请求'));
  }

  // 发送 Http Get 请求
  Future<void> _doGetClick() async {
    final url = Uri.parse('https://vercel.com/design.md');
    final response = await http.get(url);
    if (!mounted) {
      return;
    }
    if (response.statusCode == 200) {
      setState(() {
        responseData = response.body;
      });
    } else {
      setState(() {
        responseData = 'GET 请求失败（${response.statusCode}）：${response.body}';
      });
    }
  }

  // 发送 Http Post 请求
  Future<void> _doPostClick() async {
    final uri = Uri.parse('https://httpbin.org/post');
    const params = {'key': 'value222'};
    final response = await http.post(uri, body: params);
    if (!mounted) {
      return;
    }
    if (response.statusCode == 200) {
      setState(() {
        responseData = response.body;
      });
    } else {
      setState(() {
        responseData = 'POST 请求失败（${response.statusCode}）：${response.body}';
      });
    }
  }
}
