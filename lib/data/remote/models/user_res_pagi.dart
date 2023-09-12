import 'package:admin/data/remote/models/user_res.dart';

class UserAPIResPagi {
  List<UserAPIModel>? data;
  int? total;
  int? count;

  UserAPIResPagi({this.data, this.total, this.count});

  UserAPIResPagi.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserAPIModel>[];
      json['data'].forEach((v) {
        data!.add(UserAPIModel.fromJson(v));
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
