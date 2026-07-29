import 'package:flutter/cupertino.dart';

// 扩展 int 类型以方便使用
extension IntFix on int {
  // eg: 200.px
  double get px {
    return ScreenHelper.getPx(toDouble());
  }
}

// 扩展 double 类型以方便使用
extension DoubleFix on double {
  // eg: 200.0.px
  double get px {
    return ScreenHelper.getPx(this);
  }
}

class ScreenHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double ratio;

  // 根据设计稿的宽度进行适配
  static void init(BuildContext context, {double baseWidth = 375}) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    ratio = screenWidth / baseWidth;
  }

  // 获取设计稿对应的尺寸
  static double getPx(double size) {
    return ScreenHelper.ratio * size;
  }
}
