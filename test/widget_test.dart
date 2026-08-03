import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/main.dart';

void main() {
  testWidgets('JSON 转 Model 显示嵌套 data 中的字段', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.tap(find.text('JSON 转 Model'));
    await tester.pump();
    expect(find.text('解析的结果：time: 123, method: get, requestId: 1687331550'), findsOneWidget);
  });
}
