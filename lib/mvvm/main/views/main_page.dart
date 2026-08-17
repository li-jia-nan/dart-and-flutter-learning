import 'package:flutter/material.dart';
import 'package:learning_app/dao/login_dao.dart';
import 'package:learning_app/mvvm/main/views/bottom_tab_view.dart';
import 'package:learning_app/utils/screen_adapter_helper.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: LoginDao.getBoardingPass(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        ScreenHelper.init(context);
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const BottomTabView();
          } else {
            return const BottomTabView();
          }
        } else {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
