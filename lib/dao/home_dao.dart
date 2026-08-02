import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app/dao/header_util.dart';
import 'package:learning_app/model/home_model.dart';
import 'package:learning_app/utils/navigator_util.dart';

class HomeDao {
  static const String _mockDataAsset = 'lib/model/home-data.json';

  static Future<Data?> fetch() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await http.get(url, headers: hiHeaders());
    Utf8Decoder utf8Decoder = const Utf8Decoder();
    String responseBody = utf8Decoder.convert(response.bodyBytes);
    if (response.statusCode == 401) {
      NavigatorUtil.goToLogin();
      return null;
    }

    if (response.statusCode == 200) {
      final data = _parseData(responseBody);
      if (data != null) {
        return data;
      }
    }

    // 接口失败或响应中没有 data 时，使用本地模拟数据。
    final mockResponseBody = await rootBundle.loadString(_mockDataAsset);
    return _parseData(mockResponseBody);
  }

  static Data? _parseData(String responseBody) {
    final result = jsonDecode(responseBody);
    if (result is! Map<String, dynamic>) {
      return null;
    }
    final data = result['data'];
    if (data is! Map<String, dynamic>) {
      return null;
    }
    Data dataModel = Data.fromJson(data);
    return dataModel;
  }
}
