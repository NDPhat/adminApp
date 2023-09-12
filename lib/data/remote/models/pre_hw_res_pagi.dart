import 'package:admin/data/remote/models/pre_hw_res.dart';

class PreHWAPIResPagi {
  List<PreHWAPIModel>? data;
  int? total;
  int? count;

  PreHWAPIResPagi({this.data, this.total, this.count});

  PreHWAPIResPagi.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PreHWAPIModel>[];
      json['data'].forEach((v) {
        data!.add( PreHWAPIModel.fromJson(v));
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
