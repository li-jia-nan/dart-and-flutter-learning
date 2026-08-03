// 旅拍模块 Dao
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app/dao/header_util.dart';
import 'package:learning_app/model/travel_category_model.dart';
import 'package:learning_app/model/travel_tab_model.dart';
import 'package:learning_app/utils/navigator_util.dart';

class TravelDao {
  static const String _mockCategoryData = 'lib/model/travel-category-data.json';
  static const String _mockTabData = 'lib/model/travel-tab-data.json';

  // 获取旅拍类别
  static Future<TravelCategoryModel?> getCategory() async {
    var url = Uri.parse('https://api.devio.org/uapi/travel/list');
    final response = await http.get(url, headers: await hiHeaders());
    Utf8Decoder utf8Decoder = const Utf8Decoder();
    String responseBody = utf8Decoder.convert(response.bodyBytes);
    if (response.statusCode == 401) {
      NavigatorUtil.goToLogin();
      return null;
    }

    if (response.statusCode == 200) {
      final data = _parseCategoryData(responseBody);
      if (data != null) {
        return data;
      }
    }

    // 接口失败或响应中没有 data 时，使用本地模拟数据。
    final mockResponseBody = await rootBundle.loadString(_mockCategoryData);
    return _parseCategoryData(mockResponseBody);
  }

  // 获取旅拍类别下的旅拍列表
  static Future<TravelTabModel?> getTravels(
    String groupChannelCode,
    int pageIndex,
    int pageSize,
  ) async {
    Map<String, String> paramsMap = {
      'pageIndex': pageIndex.toString(),
      'pageSize': pageSize.toString(),
      'groupChannelCode': groupChannelCode,
    };
    var url = Uri.https('api.devio.org', '/uapi/travel/list', paramsMap);
    final response = await http.get(url, headers: await hiHeaders());
    Utf8Decoder utf8Decoder = const Utf8Decoder();
    String responseBody = utf8Decoder.convert(response.bodyBytes);
    if (response.statusCode == 401) {
      NavigatorUtil.goToLogin();
      return null;
    }

    if (response.statusCode == 200) {
      final data = _parseTabData(responseBody);
      if (data != null) {
        return data;
      }
    }

    // 接口失败或响应中没有 data 时，使用本地模拟数据。
    final mockResponseBody = await rootBundle.loadString(_mockTabData);
    return _parseTabData(mockResponseBody);
  }

  static TravelCategoryModel? _parseCategoryData(String responseBody) {
    final result = jsonDecode(responseBody);
    if (result is! Map<String, dynamic>) {
      return null;
    }
    TravelCategoryModel dataModel = TravelCategoryModel.fromJson(result);
    return dataModel;
  }

  static TravelTabModel? _parseTabData(String responseBody) {
    final result = jsonDecode(responseBody);
    if (result is! Map<String, dynamic>) {
      return null;
    }
    TravelTabModel dataModel = TravelTabModel.fromJson(result);
    return dataModel;
  }
}
