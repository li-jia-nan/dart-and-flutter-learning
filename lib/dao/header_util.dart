import 'package:learning_app/dao/login_dao.dart';

Future<Map<String, String>> hiHeaders() async {
  final boardingPass = await LoginDao.getBoardingPass();
  return {
    'auto-token': 'aaaaaabbbbbbccccccc',
    if (boardingPass != null && boardingPass.isNotEmpty) 'boarding-pass': boardingPass,
  };
}
