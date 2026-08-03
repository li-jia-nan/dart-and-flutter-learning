import 'package:flutter/widgets.dart';
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
    return const Placeholder();
  }

  void _initWebViewController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            // 页面加载完成之后才能执行 js
            _handBackForbid(url);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.toString());
          },
          onNavigationRequest: (NavigationRequest request) {
            if (_isToMain(request.url)) {
              debugPrint('blocking navigation to ${request.url}');
              NavigatorUtil.pop(context);
              return NavigationDecision.prevent;
            } else {
              debugPrint('allowing navigation to ${request.url}');
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
}
