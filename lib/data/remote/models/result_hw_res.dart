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
  String? dateSave;
  int? falseQ;
  String? key;
  String? lop;
  String? name;
  int? numQ;
  int? score;
  int? trueQ;
  String? userId;
  String? week;

  ResultQuizHWAPIModel(
      {this.dateSave,
      this.falseQ,
      this.key,
      this.lop,
      this.name,
      this.numQ,
      this.score,
      this.trueQ,
      this.userId,
      this.week});

  ResultQuizHWAPIModel.fromJson(Map<String, dynamic> json) {
    dateSave = json['dateSave'];
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
    data['dateSave'] = this.dateSave;
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
