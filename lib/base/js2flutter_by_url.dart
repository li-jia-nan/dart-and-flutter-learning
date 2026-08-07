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
          // 通过 URL 传递参数给 Flutter
          document.location = "hi://webview?name=张三&age=18";
        },
        false,
      );
    </script>
  </body>
</html>
''';

//  Js 向 flutter 传递参数
class Js2flutterByUrl extends StatefulWidget {
  const Js2flutterByUrl({super.key});

  @override
  State<Js2flutterByUrl> createState() => _Js2flutterByUrlState();
}

class _Js2flutterByUrlState extends State<Js2flutterByUrl> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            // 约定一个通信协议 hi://webview
            if (request.url.startsWith('hi://webview')) {
              debugPrint('处理 JS 通过 url 传递过来的数据: $request');
              Uri uri = Uri.parse(request.url);
              // 解析参数
              var name = uri.queryParameters['name'];
              debugPrint('name: $name');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('name: $name')));
              return NavigationDecision.prevent; // 阻止 WebView 继续加载这个 url
            } else {
              debugPrint('继续加载 url: $request');
              return NavigationDecision.navigate; // 允许 WebView 继续加载这个 url
            }
          },
        ),
      );
  }

  Widget get _loadBtn => FilledButton(
    onPressed: () {
      _controller.loadHtmlString(h5JS2FlutterByUrl);
    },
    child: const Text('加载 h5 页面', style: TextStyle(color: Colors.black, fontSize: 16)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('通过 Js 向 flutter 传递参数'), actions: [_loadBtn]),
      body: WebViewWidget(controller: _controller),
    );
  }
}
