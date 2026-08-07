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
    <button id="btn" style="font-size: 16px">传递参数</button>
    <script>
      const btn = document.getElementById("btn");
      btn.addEventListener(
        "click",
        () => {
          hiPop.postMessage({ name: "lijianan", age: 18 });
        },
        false,
      );
    </script>
  </body>
</html>
''';

//  Js 向 flutter 传递参数
class Js2flutterByChannel extends StatefulWidget {
  const Js2flutterByChannel({super.key});

  @override
  State<Js2flutterByChannel> createState() => _Js2flutterByChannelState();
}

class _Js2flutterByChannelState extends State<Js2flutterByChannel> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'hiPop',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('处理 JS 通过 channel 传递过来的数据: ${message.message}');
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('message: ${message.message}')));
        },
      );
  }

  Widget get _loadBtn => FilledButton(
    onPressed: () {
      _controller.loadHtmlString(h5JS2FlutterByUrl);
    },
    child: const Text('加载 h5 页面', style: TextStyle(color: Colors.white, fontSize: 16)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Js 向 flutter 传递参数'), actions: [_loadBtn]),
      body: WebViewWidget(controller: _controller),
    );
  }
}
