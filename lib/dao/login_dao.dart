import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_app/dao/header_util.dart';
import 'package:learning_app/utils/navigator_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 登录接口
class LoginDao {
  static const boardingPass = 'boarding_pass';
  static Future<void> login({required String userName, required String password}) async {
    Map<String, String> paramsMap = {'userName': userName, 'password': password};
    var uri = Uri.https('api.devio.org', '/uapi/user/login', paramsMap);
    final response = await http.post(uri, headers: hiHeaders(), body: paramsMap);
    Utf8Decoder utf8decoder = const Utf8Decoder(); // 修复中文乱码
    String bodyString = utf8decoder.convert(response.bodyBytes);
    if (response.statusCode == 200) {
      var resultData = json.decode(bodyString);
      if (resultData['code'] == 0 && resultData['data'] != null) {
        _saveBoardingPass(resultData['data']);
      } else {
        _saveBoardingPass('dsdsdsds'); // 模拟登录成功，保存 boarding_pass
      }
    } else {
      _saveBoardingPass('dsdsdsds'); // 模拟登录成功，保存 boarding_pass
    }
  }

  static Future<void> _saveBoardingPass(String value) async {
    final prefs = SharedPreferencesAsync();
    await prefs.setString(boardingPass, value);
  }

  static Future<String?> getBoardingPass() async {
    final prefs = SharedPreferencesAsync();
    return await prefs.getString(boardingPass);
  }

  // 退出登录
  static Future<void> logOut() async {
    final prefs = SharedPreferencesAsync();
    await prefs.remove(boardingPass);
    NavigatorUtil.goToLogin();
  }
}
