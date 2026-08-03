import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app/dao/header_util.dart';
import 'package:learning_app/model/search_model.dart';
import 'package:learning_app/utils/navigator_util.dart';

// 搜索接口
class SearchDao {
  static const String _mockDataAsset = 'lib/model/search-data.json';

  static Future<SearchModel?> fetch(String keyword) async {
    var url = Uri.parse('https://api.devio.org/uapi/search?q=$keyword');
    final response = await http.get(url, headers: await hiHeaders());
    Utf8Decoder utf8Decoder = const Utf8Decoder();
    String responseBody = utf8Decoder.convert(response.bodyBytes);
    if (response.statusCode == 401) {
      NavigatorUtil.goToLogin();
      return null;
    }

    if (response.statusCode == 200) {
      final data = _parseData(responseBody, keyword);
      if (data != null) {
        return data;
      }
    }

    // 接口失败或响应中没有 data 时，使用本地模拟数据。
    final mockResponseBody = await rootBundle.loadString(_mockDataAsset);
    return _parseData(mockResponseBody, keyword);
  }

  static SearchModel? _parseData(String responseBody, String keyword) {
    final result = jsonDecode(responseBody);
    if (result is! Map<String, dynamic>) {
      return null;
    }
    SearchModel dataModel = SearchModel.fromJson(result);
    dataModel.keyword = keyword; // 设置搜索关键字
    return dataModel;
  }
}
