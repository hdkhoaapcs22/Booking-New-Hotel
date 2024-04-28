class MyUser {
  late String _uid, _name, _email, _address, _phone;

  // MyUser({required String uid}) : _uid = uid;

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
      required String address,
      required String phone}) {
    _name = name;
    if (email != null) {
      _email = email;
    }
    _address = address;
    _phone = phone;
  }

  String get getUID => _uid;
  String get getEmail => _email;
}
