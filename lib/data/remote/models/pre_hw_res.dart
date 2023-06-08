class PreHWResAPI {
  int? iCount;
  Null? nLast;
  List<PreHWResModel>? lItems;

  PreHWResAPI({this.iCount, this.nLast, this.lItems});

  PreHWResAPI.fromJson(Map<String, dynamic> json) {
    iCount = json['_count'];
    nLast = json['_last'];
    if (json['_items'] != null) {
      lItems = <PreHWResModel>[];
      json['_items'].forEach((v) {
        lItems!.add(new PreHWResModel.fromJson(v));
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

class PreHWResModel {
  String? color;
  String? dend;
  String? dstart;
  int? eNum;
  String? key;
  int? numQ;
  int? sNum;
  List<String>? sign;
  String? status;
  String? week;

  PreHWResModel(
      {this.color,
        this.dend,
        this.dstart,
        this.eNum,
        this.key,
        this.numQ,
        this.sNum,
        this.sign,
        this.status,
        this.week});

  PreHWResModel.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    dend = json['dend'];
    dstart = json['dstart'];
    eNum = json['eNum'];
    key = json['key'];
    numQ = json['numQ'];
    sNum = json['sNum'];
    sign = json['sign'].cast<String>();
    status = json['status'];
    week = json['week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['dend'] = this.dend;
    data['dstart'] = this.dstart;
    data['eNum'] = this.eNum;
    data['key'] = this.key;
    data['numQ'] = this.numQ;
    data['sNum'] = this.sNum;
    data['sign'] = this.sign;
    data['status'] = this.status;
    data['week'] = this.week;
    return data;
  }
}
