import 'package:get/get.dart';
import 'package:learning_app/mvvm/main/binding/main_binding.dart';
import 'package:learning_app/mvvm/main/views/main_page.dart';
// import 'package:learning_app/pages/login_page.dart';
part 'app_routes.dart';

// 定义路由页面
class AppPages {
  AppPages._();

  static const init = Routes.main;
  static final routes = [
    GetPage(name: Routes.main, page: () => const MainPage(), binding: MainBinding()),
    // GetPage(name: Routes.login, page: () => const LoginPage(), binding: LoginBinding()),
  ];
}
