class ResultHWAPIReq {
  String? week;
  int? numQ;
  String? userId;
  String? name;
  String? lop;
  int? score;
  int? trueQ;
  int? falseQ;

  ResultHWAPIReq(
      {this.week,
      this.numQ,
      this.userId,
      this.score,
      this.trueQ,
      this.falseQ,
      this.name,
      this.lop});

  ResultHWAPIReq.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    numQ = json['numQ'];
    userId = json['userId'];
    lop = json['lop'];
    score = json['score'];
    trueQ = json['trueQ'];
    name = json['name'];
    falseQ = json['falseQ'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week'] = this.week;
    data['numQ'] = this.numQ;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['score'] = this.score;
    data['lop'] = this.lop;
    data['trueQ'] = this.trueQ;
    data['falseQ'] = this.falseQ;
    return data;
  }
}
