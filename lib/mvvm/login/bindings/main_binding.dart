import 'package:get/get.dart';
import 'package:learning_app/mvvm/login/controllers/controller.dart';

// 使用 Get.lazyPut 实例化 LoginViewModel
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginViewModel>(() => LoginViewModel());
  }
}
