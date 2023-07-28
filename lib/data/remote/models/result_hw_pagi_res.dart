class ResultHWPagiAPI {
  List<ResultHWPagiModel>? data;
  int? total;
  int? count;

  ResultHWPagiAPI({this.data, this.total, this.count});

  ResultHWPagiAPI.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ResultHWPagiModel>[];
      json['data'].forEach((v) {
        data!.add(new ResultHWPagiModel.fromJson(v));
      });
    }
    total = json['total'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['count'] = this.count;
    return data;
  }
}

class ResultHWPagiModel {
  int? falseQ;
  String? key;
  String? lop;
  String? name;
  int? numQ;
  int? score;
  int? trueQ;
  String? userId;
  String? week;

  ResultHWPagiModel(
      {this.falseQ,
      this.key,
      this.lop,
      this.name,
      this.numQ,
      this.score,
      this.trueQ,
      this.userId,
      this.week});

  ResultHWPagiModel.fromJson(Map<String, dynamic> json) {
    falseQ = json['falseQ'];
    key = json['key'];
    lop = json['lop'];
    name = json['name'];
    numQ = json['numQ'];
    score = json['score'];
    trueQ = json['trueQ'];
    userId = json['userId'];
    week = json['week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['falseQ'] = this.falseQ;
    data['key'] = this.key;
    data['lop'] = this.lop;
    data['name'] = this.name;
    data['numQ'] = this.numQ;
    data['score'] = this.score;
    data['trueQ'] = this.trueQ;
    data['userId'] = this.userId;
    data['week'] = this.week;
    return data;
  }
}
