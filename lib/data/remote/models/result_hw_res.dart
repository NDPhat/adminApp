class ResultHWAPIRes {
  int? iCount;
  Null? nLast;
  List<ResultHWAPIModel>? lItems;

  ResultHWAPIRes({this.iCount, this.nLast, this.lItems});

  ResultHWAPIRes.fromJson(Map<String, dynamic> json) {
    iCount = json['_count'];
    nLast = json['_last'];
    if (json['_items'] != null) {
      lItems = <ResultHWAPIModel>[];
      json['_items'].forEach((v) {
        lItems!.add(new ResultHWAPIModel.fromJson(v));
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

class ResultHWAPIModel {
  String? key;
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
  ResultHWAPIModel(
      {this.dateSave,
      this.falseQ,
      this.key,
      this.lop,
      this.name,
      this.numQ,
      this.score,
      this.trueQ,
      this.status,
      this.userId,
      this.week});

  ResultHWAPIModel.fromJson(Map<String, dynamic> json) {
    dateSave = json['dateSave'];
    falseQ = json['falseQ'];
    key = json['key'];
    lop = json['lop'];
    name = json['name'];
    numQ = json['numQ'];
    score = json['score'];
    trueQ = json['trueQ'];
    userId = json['userId'];
    status = json['status'];

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
    data['status'] = this.status;

    return data;
  }
}
