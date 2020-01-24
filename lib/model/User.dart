class User {
  int _id;
  String _fullname;
  String _email;
  String _username;
  String _password;

  User(this._fullname, this._email, this._username, this._password);
  User.withId(
      this._id, this._fullname, this._email, this._username, this._password);

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get username => _username;

  set username(String value) {
    _username = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get fullname => _fullname;

  set fullname(String value) {
    _fullname = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  ///convert a user to map format
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['fullname'] = _fullname;
    map['email'] = _email;
    map['username'] = _username;
    map['password'] = _password;
    return map;
  } //toMap

  //extract a user form the map object
  User.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._fullname = map['fullname'];
    this._email = map['email'];
    this._username = map['username'];
    this._password = map['password'];
  }
}
