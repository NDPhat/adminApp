class ResultQuizHWAPIResponse {
  int? iCount;
  Null? nLast;
  List<ResultQuizHWAPIModel>? lItems;

  ResultQuizHWAPIResponse({this.iCount, this.nLast, this.lItems});

  ResultQuizHWAPIResponse.fromJson(Map<String, dynamic> json) {
    iCount = json['_count'];
    nLast = json['_last'];
    if (json['_items'] != null) {
      lItems = <ResultQuizHWAPIModel>[];
      json['_items'].forEach((v) {
        lItems!.add(new ResultQuizHWAPIModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_count'] = this.iCount;
    data['_last'] = this.nLast;
    if (this.lItems != null) {
      data['_items'] = this.lItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultQuizHWAPIModel {
  int? falseQ;
  String? key;
  int? numQ;
  String? name;
  int? score;
  int? trueQ;
  String? userId;
  String? week;
  String? lop;

  ResultQuizHWAPIModel(
      {this.falseQ,
      this.key,
      this.numQ,
      this.score,
      this.lop,
      this.trueQ,
      this.name,
      this.userId,
      this.week});

  ResultQuizHWAPIModel.fromJson(Map<String, dynamic> json) {
    falseQ = json['falseQ'];
    key = json['key'];
    numQ = json['numQ'];
    score = json['score'];
    trueQ = json['trueQ'];
    lop = json['lop'];
    name = json['name'];
    userId = json['userId'];
    week = json['week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['falseQ'] = this.falseQ;
    data['key'] = this.key;
    data['numQ'] = this.numQ;
    data['score'] = this.score;
    data['name'] = this.name;
    data['trueQ'] = this.trueQ;
    data['userId'] = this.userId;
    data['lop'] = this.lop;
    data['week'] = this.week;
    return data;
  }
}
