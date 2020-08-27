class Course {
  int _id;
  String _name;
  String _content;
  String _hours;
  int _color;
  int _selcolornum;
  Course(dynamic obj) {
    _id = obj['id'];
    _name = obj['name'];
    _content = obj['content'];
    _hours = obj['hours'];
    _color = obj['color'];
    _selcolornum = obj['selcolornum'];
  }
  Course.fromMap(Map<String, dynamic> data) {
    _id = data['id'];
    _name = data['name'];
    _content = data['content'];
    _hours = data['hours'];
    _color = data['color'];
    _selcolornum = data['selcolornum'];
  }
  Map<String, dynamic> toMAp() => {
        'id': _id,
        'name': _name,
        'content': _content,
        'hours': _hours,
        'color': _color,
        'selcolornum': _selcolornum
      };

  int get id => _id;
  String get name => _name;
  String get content => _content;
  String get hours => _hours;
  int get color => _color;
  int get selcolornum => _selcolornum;
}
