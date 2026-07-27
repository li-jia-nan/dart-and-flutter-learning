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
              child: SelectableText('Http Get 请求结果：$responseData'),
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
    if (response.statusCode == 200) {
      debugPrint('请求成功，响应数据：${response.body}');
      setState(() {
        responseData = response.body;
      });
    } else {
      setState(() {
        responseData = '请求失败：${response.body}';
      });
    }
  }

  // 发送 Http Post 请求
  Future<void> _doPostClick() async {
    final uri = Uri.parse('https://postman-echo.com/post');
    const params = {'key': 'value'}; // 这里可以根据实际需求设置请求参数
    final response = await http.post(uri, body: params);
    if (response.statusCode == 200) {
      debugPrint('POST 请求成功，响应数据：${response.body}');
      setState(() {
        responseData = response.body;
      });
    } else {
      setState(() {
        responseData = 'POST 请求失败：${response.body}';
      });
    }
  }
}
