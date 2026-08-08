import 'package:flutter/material.dart';
import 'package:learning_app/base/flutter2js_by_javascript.dart';
import 'package:learning_app/base/flutter2js_by_url.dart';
import 'package:learning_app/base/js2flutter_by_channel.dart';
import 'package:learning_app/base/js2flutter_by_url.dart';
import 'package:learning_app/jump/flutter_h5_jump_asset.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _navButton(context, const Js2flutterByUrl(), 'Js 向 flutter 传递参数，通过 url'),
            _navButton(context, const Js2flutterByChannel(), 'Js 向 flutter 传递参数，通过 channel'),
            _navButton(context, const Flutter2jsByUrl(), 'flutter 向 Js 传递参数，通过 url'),
            _navButton(context, const Flutter2jsByJavascript(), 'flutter 向 Js 传递参数，通过运行 js'),
            _navButton(context, const FlutterH5JumpAsset(), '通过 loadFlutterAsset 加载 H5 页面'),
          ],
        ),
      ),
    );
  }

  Widget _navButton(BuildContext context, Widget page, String title) {
    return FilledButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Text(title),
    );
  }
}
