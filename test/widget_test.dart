import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/main.dart';

void main() {
  testWidgets('首页显示 JS 与 Flutter 通信入口', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Flutter Demo Home Page'), findsOneWidget);
    expect(find.text('通过 Js 向 flutter 传递参数'), findsOneWidget);
  });
}
