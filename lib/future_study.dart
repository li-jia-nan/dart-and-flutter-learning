import 'dart:convert';
import 'package:flutter/material.dart';
import 'data_model.dart';
import 'package:http/http.dart' as http;

class FutureStudy extends StatefulWidget {
  const FutureStudy({super.key});

  @override
  State<FutureStudy> createState() => _FutureStudyState();
}

class _FutureStudyState extends State<FutureStudy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Future 与 FutureBuilder 应用实战')),
      body: FutureBuilder<DataModel>(
        future: fetchGet(),
        builder: (BuildContext context, AsyncSnapshot<DataModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('未开始网络请求');
            case ConnectionState.waiting:
              return const CircularProgressIndicator();
            case ConnectionState.active:
              return const Text('ConnectionState.active');
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final data = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('time: ${data.time}'),
                    Text('method: ${data.method}'),
                    Text('requestId: ${data.requestId}'),
                  ],
                );
              }
          }
        },
      ),
    );
  }

  // 发送 Http Get 请求
  Future<DataModel> fetchGet() async {
    final url = Uri.parse('https://vercel.com/design.md');
    final response = await http.get(url);
    if (!mounted) {
      throw Exception('Widget is not mounted');
    }
    var result = jsonDecode(response.body);
    return DataModel.fromJson(result);
  }
}
