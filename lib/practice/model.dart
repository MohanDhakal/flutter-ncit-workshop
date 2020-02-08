class Note {
  String _title, _body;
  int _id;

  Note() {}

  Note.name(this._title, this._body, this._id);

  int get id => _id;

  set id(int value) {
    _id = value;
  }

  get body => _body;

  set body(value) {
    _body = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }
}
