import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/model/travel_tab_model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('旅拍模拟数据可以解析为 TravelItem 列表', () async {
    final source = await rootBundle.loadString('lib/model/travel-tab-data.json');
    final json = jsonDecode(source) as Map<String, dynamic>;

    final model = TravelTabModel.fromJson(json);

    expect(model.data.list, hasLength(5));
    expect(model.data.list.first.article.images.first.width, 1920);
    expect(model.data.list.first.article.video.width, 858);
  });
}
