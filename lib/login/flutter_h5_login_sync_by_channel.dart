import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5LoginInfo = '''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Flutter 通过 Channel 的方式将登录状态同步给 H5</title>
  </head>
  <body>
    <button type="button" id="btn" style="font-size: 16px; font-weight: bolder">
      获取登录信息
    </button>
    <div id="resultText" style="font-size: 20px; font-weight: bolder">
      这里展示 Flutter 传递过来的数据
    </div>
    <script>
      const btn = document.getElementById("btn");
      btn.addEventListener(
        "click",
        () => {
          // 通过注册的 Channel 方法向 Flutter 发送消息，获取登录信息
          window.getLoginInfo.postMessage("获取登录信息");
        },
        false,
      );
      const resultText = document.getElementById("resultText");
      const hiCallJs = (msg) => {
        resultText.innerHTML = "Flutter 传递过来的数据：" + msg;
      };
    </script>
  </body>
</html>
''';

// Flutter 通过 Channel 的方式将登录状态同步给 H5
class FlutterH5LoginSyncByChannel extends StatefulWidget {
  const FlutterH5LoginSyncByChannel({super.key});

  @override
  State<FlutterH5LoginSyncByChannel> createState() => _FlutterH5LoginSyncByChannelState();
}

class _FlutterH5LoginSyncByChannelState extends State<FlutterH5LoginSyncByChannel> {
  late WebViewController _controller;

  Widget get _loadBtn => FilledButton(
    onPressed: () {
      _controller.loadHtmlString(h5LoginInfo);
    },
    child: const Text('加载 H5 页面', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
  );

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'getLoginInfo',
        onMessageReceived: (JavaScriptMessage message) {
          debugPrint('处理 H5 通过 channel 传递过来的数据: ${message.message}');
          const info = {"name": "lijianan-yuyuyu", "age": '18', 'uid': '123456'};
          final infoString = json.encode(info);
          // 调用 H5 的方法，将登录信息传递给 H5
          _controller.runJavaScript('hiCallJs($infoString)');
        },
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter 通过 Channel 的方式将登录状态同步给 H5'),
        actions: <Widget>[_loadBtn],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
