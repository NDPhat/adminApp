import 'package:admin/data/remote/models/pre_hw_res.dart';

class PreHWResPagiAPI {
  List<PreHWResModel>? data;
  int? total;
  int? count;

  PreHWResPagiAPI({this.data, this.total, this.count});

  PreHWResPagiAPI.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <PreHWResModel>[];
      json['data'].forEach((v) {
        data!.add( PreHWResModel.fromJson(v));
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
