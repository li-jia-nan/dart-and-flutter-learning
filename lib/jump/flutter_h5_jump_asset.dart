import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 通过 loadFlutterAsset 加载 H5 页面
class FlutterH5JumpAsset extends StatefulWidget {
  const FlutterH5JumpAsset({super.key});

  @override
  State<FlutterH5JumpAsset> createState() => _FlutterH5JumpAssetState();
}

class _FlutterH5JumpAssetState extends State<FlutterH5JumpAsset> {
  late WebViewController _controller;

  Widget get _loadBtn => FilledButton(
    onPressed: () {
      _onLoadFlutterAsset(context);
    },
    child: const Text('加载 H5', style: TextStyle(fontSize: 16, color: Colors.white)),
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
        title: const Text('通过 loadFlutterAsset 加载 H5 页面'),
        actions: <Widget>[_loadBtn],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  Future<void> _onLoadFlutterAsset(BuildContext context) async {
    // 通过 loadFlutterAsset 加载 H5 页面
    await _controller.loadFlutterAsset('assets/hiH5/index.html');
  }
}
