// 工程级别的绑定
import 'package:get/get.dart';
import 'package:learning_app/mvvm/login/bindings/main_binding.dart';
import 'package:learning_app/mvvm/main/binding/main_binding.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    MainBinding().dependencies();
    LoginBinding().dependencies();
  }
}
