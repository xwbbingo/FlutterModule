class UserManager {
  factory UserManager() => _getInstance();

  static UserManager get instance => _getInstance();

  static UserManager _instance;

  UserManager._internal();

  static UserManager _getInstance() {
    if (_instance == null) {
      _instance = UserManager._internal();
    }
    return _instance;
  }
}
