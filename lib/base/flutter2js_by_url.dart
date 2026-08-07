import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//  flutter 向 js 传递参数
class Flutter2jsByUrl extends StatefulWidget {
  const Flutter2jsByUrl({super.key});

  @override
  State<Flutter2jsByUrl> createState() => _Flutter2jsByUrlState();
}

class _Flutter2jsByUrlState extends State<Flutter2jsByUrl> {
  late WebViewController _controller;

  int progress = 0; // 进度条进度

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) => {
            setState(() {
              this.progress = progress;
            }),
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('继续加载 url: $request');
            return NavigationDecision.navigate; // 允许 WebView 继续加载这个 url
          },
        ),
      );
  }

  Widget get _loadBtn => FilledButton(
    onPressed: () {
      // 加载一个带参数的 url，js 可以通过 url 获取参数
      _controller.loadRequest(
        Uri.parse(
          'https://www.geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=wewewewew&age=188',
        ),
      );
    },
    child: const Text('加载 h5 页面', style: TextStyle(color: Colors.white, fontSize: 16)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('flutter 向 Js 传递参数'), actions: <Widget>[_loadBtn]),
      body: Stack(
        children: [
          LinearProgressIndicator(
            value: progress / 100,
            backgroundColor: Colors.grey[200],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          WebViewWidget(controller: _controller),
          Positioned(bottom: 100, left: 10, child: Text('加载进度: $progress%')),
        ],
      ),
    );
  }
}
