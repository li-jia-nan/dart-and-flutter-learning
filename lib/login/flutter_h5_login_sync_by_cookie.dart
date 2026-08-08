import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Flutter 通过 Cookie 同步登录
class FlutterH5LoginSyncByCookie extends StatefulWidget {
  const FlutterH5LoginSyncByCookie({super.key});

  @override
  State<FlutterH5LoginSyncByCookie> createState() => _FlutterH5LoginSyncByCookieState();
}

class _FlutterH5LoginSyncByCookieState extends State<FlutterH5LoginSyncByCookie> {
  final WebViewCookieManager _cookieManager = WebViewCookieManager();
  late WebViewController _controller;

  Widget get _loadBtn => FilledButton(
    onPressed: () {
      _controller.loadRequest(
        Uri.parse(
          'https://geekailab.com/io/flutter-trip/Flutter2JSByUrl.html?name=li-flutter&age=18',
        ),
      );
    },
    child: const Text('加载 H5 页面', style: TextStyle(fontSize: 16, color: Colors.white)),
  );

  Widget get _setCookieBtn => FilledButton(
    onPressed: () {
      _onSetCookie(context);
    },
    child: const Text('设置 Cookie', style: TextStyle(fontSize: 16, color: Colors.white)),
  );

  Widget get _clearCookieBtn => FilledButton(
    onPressed: () {
      _onClearCookie(context);
    },
    child: const Text('清除 Cookie', style: TextStyle(fontSize: 16, color: Colors.white)),
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
        title: const Text('Flutter 通过 Cookie 同步登录状态给 H5 页面'),
        actions: <Widget>[_loadBtn, _setCookieBtn, _clearCookieBtn],
      ),
      body: WebViewWidget(controller: _controller),
    );
  }

  Future<void> _onSetCookie(BuildContext context) async {
    await _cookieManager.setCookie(
      WebViewCookie(
        name: 'token',
        value: 'bhbhbbb_123456_789_wwwe',
        domain: 'geekailab.com',
        path: '/',
      ),
    );

    await _cookieManager.setCookie(
      WebViewCookie(
        name: 'uid',
        value: 'uid_tytytt_5555_6666_7777',
        domain: 'geekailab.com',
        path: '/',
      ),
    );

    final Object cookies = await _controller.runJavaScriptReturningResult('document.cookie');

    debugPrint('Flutter 设置 Cookie 后，H5 页面 document.cookie 的值为：$cookies');
  }

  Future<bool> _onClearCookie(BuildContext context) async {
    final bool result = await _cookieManager.clearCookies();
    if (result) {
      debugPrint('Flutter 清除 Cookie 成功');
    } else {
      debugPrint('Flutter 清除 Cookie 失败');
    }
    return result;
  }
}
