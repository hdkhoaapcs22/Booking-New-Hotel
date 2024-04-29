class MyUser {
  late String _uid, _name, _email, _password, _address, _phone;

  // singleton object
  static final MyUser _singleton = MyUser._internal();
  factory MyUser({required String uid}) {
    _singleton._uid = uid;
    return _singleton;
  }
  MyUser._internal();

  void setUserInfo(
      {required String name,
      String? email,
      String? password,
      required String address,
      required String phone}) {
    _name = name;
    if (email != null) {
      _email = email;
    }
    if (password != null) {
      _password = password;
    }
    _address = address;
    _phone = phone;
  }

  void setEmail({required String email}) {
    _email = email;
  }

  void setPassword({required String password}) {
    _password = password;
  }

  String get getUID => _uid;
  String get getEmail => _email;
  String get getPassword => _password;
}
