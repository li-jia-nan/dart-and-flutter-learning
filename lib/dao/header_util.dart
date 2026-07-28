import 'package:learning_app/dao/login_dao.dart';

Map<String, String> hiHeaders() {
  Map<String, String> headers = {
    'auto-token': 'aaaaaabbbbbbccccccc',
    'boarding-pass': LoginDao.getBoardingPass().toString(),
  };
  return headers;
}
