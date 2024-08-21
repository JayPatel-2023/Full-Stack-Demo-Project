class JokesModel {
  int? _id;
  String? _title;
  String? _punchline;

  JokesModel({int? id, String? title, String? punchline}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (punchline != null) {
      this._punchline = punchline;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get punchline => _punchline;
  set punchline(String? punchline) => _punchline = punchline;

  JokesModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _punchline = json['punchline'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this._id;
  //   data['title'] = this._title;
  //   data['punchline'] = this._punchline;
  //   return data;
  // }
}