import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String h5String = '''
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>通过 LoadFlutterAssets 的方式跳转到 H5</title>
  </head>
  <body>
    <div
      id="btn"
      style="font-size: 16px; font-weight: bold; text-align: center"
    >
      Hi h5 asset file
    </div>
  </body>
</html>
''';

// 通过 loadFile 的方式加载 H5 页面
class FlutterH5JumpHtmlFile extends StatefulWidget {
  const FlutterH5JumpHtmlFile({super.key});

  @override
  State<FlutterH5JumpHtmlFile> createState() => _FlutterH5JumpHtmlFileState();
}

class _FlutterH5JumpHtmlFileState extends State<FlutterH5JumpHtmlFile> {
  late WebViewController _controller;

  Widget get _loadBtn => FilledButton(
    onPressed: () {
      _onLoadLocalFile(context);
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
      appBar: AppBar(title: const Text('通过 loadFile 的方式加载 H5 页面'), actions: <Widget>[_loadBtn]),
      body: WebViewWidget(controller: _controller),
    );
  }

  Future<void> _onLoadLocalFile(BuildContext context) async {
    final String path = await _perpareLocalFile();
    // 通过 loadFile 加载 H5 页面
    await _controller.loadFile(path);
  }

  Future<String> _perpareLocalFile() async {
    // 将 h5String 写入到本地文件中
    final String tmpDir = (await getTemporaryDirectory()).path;
    final File file = File(path.join(tmpDir, 'hi-jianan', 'index.html'));
    await file.create(recursive: true);
    await file.writeAsString(h5String);
    return file.path;
  }
}
