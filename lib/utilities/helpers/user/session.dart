import 'package:get_storage/get_storage.dart';
import '../../constants/consts.dart';

class Session {
  static String? token;

  static String? code;

  static saveToken({String? newToken}) {
    GetStorage box = GetStorage();
    box.write(tokenString, newToken ?? token);
  }

  static getToken() async {
    GetStorage box = GetStorage();
    return await box.read(tokenString);
  }
}
