import 'package:admin/data/remote/models/result_hw_res.dart';

class ResultHWAPIResPagi {
  List<ResultHWAPIModel>? data;
  int? total;
  int? count;

  ResultHWAPIResPagi({this.data, this.total, this.count});

  ResultHWAPIResPagi.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ResultHWAPIModel>[];
      json['data'].forEach((v) {
        data!.add(ResultHWAPIModel.fromJson(v));
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
