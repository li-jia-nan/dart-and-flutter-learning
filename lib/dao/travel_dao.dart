// 旅拍模块 Dao
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app/dao/header_util.dart';
import 'package:learning_app/model/travel-category-model.dart';
import 'package:learning_app/utils/navigator_util.dart';

class TravelDao {
  static const String _mockDataAsset = 'lib/model/travel-category-data.json';

  // 获取旅拍类别列表
  static Future<TravelCategoryModel?> getCategory() async {
    var url = Uri.parse('https://api.devio.org/uapi/travel/list');
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

  static TravelCategoryModel? _parseData(String responseBody) {
    final result = jsonDecode(responseBody);
    if (result is! Map<String, dynamic>) {
      return null;
    }
    TravelCategoryModel dataModel = TravelCategoryModel.fromJson(result);
    return dataModel;
  }
}
