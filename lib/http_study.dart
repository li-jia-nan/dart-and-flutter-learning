import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpStudy extends StatefulWidget {
  const HttpStudy({super.key});

  @override
  State<HttpStudy> createState() => _HttpStudyState();
}

class _HttpStudyState extends State<HttpStudy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('基于 Http 实现网络操作 - Flutter 网络开发实战应用')),
      body: Column(children: [_doGetBtn()]),
    );
  }
}

Widget _doGetBtn() {
  return ElevatedButton(onPressed: _doGetClick, child: const Text('发送 Http Get 请求'));
}

// 发送 Http Get 请求
Future<void> _doGetClick() async {
  try {
    final url = Uri.parse('https://vercel.com/design.md');
    final response = await http.get(url);

    debugPrint('请求 response: $response');

    if (response.statusCode == 200) {
      debugPrint('请求成功，响应数据：${response.body}');
    } else {
      debugPrint('请求失败，状态码：${response.statusCode}');
    }
  } catch (error, stackTrace) {
    debugPrint('请求异常：$error');
    debugPrintStack(stackTrace: stackTrace);
  }
}
