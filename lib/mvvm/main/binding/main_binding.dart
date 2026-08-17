import 'package:get/get.dart';
import 'package:learning_app/mvvm/main/controllers/controller.dart';

// MainViewModel 绑定类
class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainViewModel());
  }
}
