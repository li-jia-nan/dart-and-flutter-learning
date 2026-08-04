import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:learning_app/utils/navigator_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

// h5 容器
class HiWebView extends StatefulWidget {
  final String? url;
  final String? satusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid; // 是否禁止返回

  const HiWebView({
    super.key,
    this.url,
    this.satusBarColor,
    this.title,
    this.hideAppBar,
    this.backForbid,
  });

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {
  final List<String> _catchUrls = ['m.ctrip.com', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];
  String? _url = '';
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _url = widget.url;
    if (_url != null && _url!.contains('ctrip.com')) {
      _url = _url!.replaceAll('http://', 'https://');
    }
    _initWebViewController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColor = widget.satusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColor == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, result) async {
        if (await _controller.canGoBack()) {
          _controller.goBack();
        } else {
          if (context.mounted) {
            NavigatorUtil.pop(context);
          }
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            _appBar(Colors.red, backButtonColor),
            Expanded(child: WebViewWidget(controller: _controller)),
          ],
        ),
      ),
    );
  }

  void _initWebViewController() {
    _controller = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);

    // webview_flutter_wkwebview does not support setBackgroundColor on macOS.
    // Calling it there tries to set WKWebView.isOpaque and throws at runtime.
    if (defaultTargetPlatform != TargetPlatform.macOS) {
      _controller.setBackgroundColor(const Color(0x00000000));
    }

    _controller
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            //
          },
          onPageStarted: (String url) {
            //
          },
          onPageFinished: (String url) {
            // 页面加载完成之后才能执行 js
            _handBackForbid(url);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('erroaaaaaar: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_isToMain(request.url)) {
              NavigatorUtil.pop(context);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(_url!));
  }

  void _handBackForbid(String url) {
    //
  }

  // 判断 h5 是否是返回到主页面
  bool _isToMain(String url) {
    return _catchUrls.any((element) => url.contains(element));
  }

  Widget _appBar(Color backgroundColor, Color backButtonColor) {
    double top = MediaQuery.of(context).padding.top;
    if (widget.hideAppBar ?? false) {
      return Container(color: backgroundColor, height: top);
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, top, 0, 0),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(children: [_backButton(backgroundColor), _title(backButtonColor)]),
      ),
    );
  }

  Widget _backButton(Color backButtonColor) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Icon(Icons.close, color: backButtonColor, size: 26),
      ),
    );
  }

  Widget _title(Color backButtonColor) {
    return Positioned(
      left: 0,
      right: 0,
      child: Center(
        child: Text(widget.title ?? '', style: TextStyle(color: backButtonColor, fontSize: 20)),
      ),
    );
  }
}
