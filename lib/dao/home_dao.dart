import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app/dao/header_util.dart';
import 'package:learning_app/utils/navigator_util.dart';

class HomeDao {
  static Future<String?> fetch() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    final response = await http.get(url, headers: hiHeaders());
    Utf8Decoder utf8Decoder = const Utf8Decoder();
    String responseBody = utf8Decoder.convert(response.bodyBytes);
    debugPrint('Response body: $responseBody');
    if (response.statusCode == 200) {
      return responseBody;
    } else {
      if (response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      } else {
        // 模拟返回假数据
        return jsonEncode({
          'userId': 1,
          'id': 1,
          'title': 'Mock Title',
          'body': 'This is a mock body for testing purposes.',
        }).toString();
      }
    }
  }
}
