
class PreHWAPIReq {
  String? week;
  int? numQ;
  List<String>? sign;
  int? sNum;
  int? eNum;
  String? dstart;
  String? dend;
  String? lop;
  String? status;
  String? color;

  PreHWAPIReq(
      {this.week,
        this.numQ,
        this.sign,
        this.lop,
        this.sNum,
        this.eNum,
        this.dstart,
        this.dend,
        this.status,
        this.color});

  PreHWAPIReq.fromJson(Map<String, dynamic> json) {
    week = json['week'];
    numQ = json['numQ'];
    sign = json['sign'].cast<String>();
    sNum = json['sNum'];
    eNum = json['eNum'];
    lop = json['lop'];
    dstart = json['dstart'];
    dend = json['dend'];
    status = json['status'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['week'] = this.week;
    data['numQ'] = this.numQ;
    data['sign'] = this.sign;
    data['sNum'] = this.sNum;
    data['eNum'] = this.eNum;
    data['lop'] = this.lop;
    data['dstart'] = this.dstart;
    data['dend'] = this.dend;
    data['status'] = this.status;
    data['color'] = this.color;
    return data;
  }
}
