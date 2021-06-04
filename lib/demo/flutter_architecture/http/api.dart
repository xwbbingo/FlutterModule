import 'package:start_app/demo/flutter_architecture/common/config.dart';

class Api {
  static const String _BASE_URL = "https://api.github.com/";

  static getAuth(code) {
    return "https://github.com/login/oauth/access_token?"
        "client_id=${Config.CLIENT_ID}"
        "&client_secret=${Config.CLIENT_SECRET}"
        "&code=${code}";
  }

  static String authorizations() {
    return "${_BASE_URL}authorizations";
  }

  static getMyUserInfo() {
    return "${_BASE_URL}user";
  }
}
