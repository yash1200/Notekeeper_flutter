class Note {
  int _id, _priority;
  String _title, _desc, _date;

  Note(this._title, this._date, this._priority, [this._desc]);

  Note.withId(this._id, this._title, this._date, this._priority, [this._desc]);

  int get id => _id;


  String get title => _title;

  String get desc => _desc;

  String get date => _date;

  int get priority => _priority;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set desc(String newDesc) {
    if (newDesc.length <= 255) {
      this._desc = newDesc;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set priority(int newPriority) {
    if (newPriority == 1 || newPriority == 2) {
      this._priority = newPriority;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = this._id;
    }
    map['title'] = this._title;
    map['desc'] = this._desc;
    map['date'] = this._date;
    map['priority'] = this._priority;
    return map;
}

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._desc = map['desc'];
    this._date = map['date'];
    this._priority = map['priority'];
  }
}
