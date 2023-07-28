class UserResPagiAPI {
  List<UserResPagiModel>? data;
  int? total;
  int? count;

  UserResPagiAPI({this.data, this.total, this.count});

  UserResPagiAPI.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserResPagiModel>[];
      json['data'].forEach((v) {
        data!.add(new UserResPagiModel.fromJson(v));
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

class UserResPagiModel {
  String? add;
  String? birthDate;
  String? email;
  String? key;
  String? linkImage;
  String? lop;
  String? name;
  String? otp;
  String? password;
  String? phone;
  String? role;
  String? sex;

  UserResPagiModel(
      {this.add,
        this.birthDate,
        this.email,
        this.key,
        this.linkImage,
        this.lop,
        this.name,
        this.otp,
        this.password,
        this.phone,
        this.role,
        this.sex});

  UserResPagiModel.fromJson(Map<String, dynamic> json) {
    add = json['add'];
    birthDate = json['birthDate'];
    email = json['email'];
    key = json['key'];
    linkImage = json['linkImage'];
    lop = json['lop'];
    name = json['name'];
    otp = json['otp'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add'] = this.add;
    data['birthDate'] = this.birthDate;
    data['email'] = this.email;
    data['key'] = this.key;
    data['linkImage'] = this.linkImage;
    data['lop'] = this.lop;
    data['name'] = this.name;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['sex'] = this.sex;
    return data;
  }
}
