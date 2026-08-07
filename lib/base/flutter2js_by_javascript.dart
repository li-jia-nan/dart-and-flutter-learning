import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5JS2FlutterByUrl = '''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <div id="resultText" style="font-size: 20px; font-weight: bold">
      这里展示 Flutter 传递过来的数据
    </div>
    <script>
      const hiCallJs = (msg) => {
        const dataDiv = document.getElementById("resultText");
        dataDiv.innerText = 'Flutter 传递过来的数据: ' + msg;
      };
      const hiCallJsWithResult = (v1, v2) => {
        return Number.parseInt(v1) + Number.parseInt(v2);
      };
    </script>
  </body>
</html>
''';

//  flutter 向 js 传递参数
class Flutter2jsByJavascript extends StatefulWidget {
  const Flutter2jsByJavascript({super.key});

  @override
  State<Flutter2jsByJavascript> createState() => _Flutter2jsByJavascriptState();
}

class _Flutter2jsByJavascriptState extends State<Flutter2jsByJavascript> {
  late WebViewController _controller;

  Widget get _loadBtn => FilledButton(
    onPressed: () {
      // 加载一个 string html，js 可以通过 url 获取参数
      _controller.loadHtmlString(h5JS2FlutterByUrl);
    },
    child: const Text('加载 h5 页面', style: TextStyle(color: Colors.white, fontSize: 16)),
  );

  Widget get _fireData => FilledButton(
    onPressed: () async {
      var name = 'lijianan-${DateTime.now().millisecondsSinceEpoch}';
      _controller.runJavaScript("hiCallJs('$name');");
      var result = await _controller.runJavaScriptReturningResult("hiCallJsWithResult(3, 57);");
      debugPrint('来自 JS 返回的结果: $result');
    },
    child: const Text('发送数据', style: TextStyle(color: Colors.white, fontSize: 16)),
  );

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter 向 Js 传递参数'),
        actions: <Widget>[_loadBtn, _fireData],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
