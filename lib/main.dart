import 'package:flutter/material.dart';
import 'package:learning_app/dao/login_dao.dart';
import 'package:learning_app/navigator/tab_navigator.dart';
import 'package:learning_app/pages/home_page.dart';
// import 'package:learning_app/pages/expansion_tile_page.dart';
// import 'package:learning_app/pages/gridview_page.dart';
// import 'package:learning_app/pages/refresh_loadmore_page.dart';
// import 'package:learning_app/pages/horizontal_list_page.dart';
// import 'package:learning_app/pages/vertical_list_page.dart';
import 'package:learning_app/utils/screen_adapter_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: FutureBuilder<String?>(
        future: LoginDao.getBoardingPass(),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          ScreenHelper.init(context);
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null) {
              return const TabNavigator();
            } else {
              return const TabNavigator();
            }
          } else {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        },
      ),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('当前点击按钮次数：'),
            Text('$_counter', style: const TextStyle(fontSize: 30)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
