class Course {
  int _id;
  int _cid;
  String _title;

  Course(this._cid, this._title);

  Course.withId(this._id, this._cid, this._title);

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  int get cid => _cid;

  set cid(int value) {
    _cid = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  ///convert a course to map format
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) map['id'] = _id;
    map['cid'] = _cid;
    map['title'] = _title;
    return map;
  } //toMap

  //extract a course form the map object
  Course.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._cid = map['cid'];
    this._title = map['title'];
  }
}
