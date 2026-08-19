import 'package:get/get.dart';
import 'package:learning_app/mvvm/main/controllers/controller.dart';

// 使用 Get.lazyPut 实例化 MainViewModel
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainViewModel>(() => MainViewModel());
  }
}
