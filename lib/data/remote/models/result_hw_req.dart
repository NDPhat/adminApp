class ResultHWAPIReq {
  String? week;
  int? numQ;
  String? name;
  String? userId;
  int? score;
  int? trueQ;
  int? falseQ;
  String? lop;
  String? dateSave;
  String? status;

  ResultHWAPIReq(
      {this.week,
      this.numQ,
      this.name,
      this.userId,
      this.score,
      this.trueQ,
      this.falseQ,
      this.lop,
      this.dateSave,
      this.status});

  ResultHWAPIReq.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    numQ = json['numQ'];
    name = json['name'];
    userId = json['userId'];
    score = json['score'];
    trueQ = json['trueQ'];
    falseQ = json['falseQ'];
    lop = json['lop'];
    dateSave = json['dateSave'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week'] = this.week;
    data['numQ'] = this.numQ;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['score'] = this.score;
    data['trueQ'] = this.trueQ;
    data['falseQ'] = this.falseQ;
    data['lop'] = this.lop;
    data['dateSave'] = this.dateSave;
    data['status'] = this.status;
    return data;
  }
}
