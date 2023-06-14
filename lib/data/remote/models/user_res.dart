class UserAPIRes {
  int? iCount;
  Null? nLast;
  List<UserAPIModel>? lItems;

  UserAPIRes({this.iCount, this.nLast, this.lItems});

  UserAPIRes.fromJson(Map<String, dynamic> json) {
    iCount = json['_count'];
    nLast = json['_last'];
    if (json['_items'] != null) {
      lItems = <UserAPIModel>[];
      json['_items'].forEach((v) {
        lItems!.add(new UserAPIModel.fromJson(v));
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

class UserAPIModel {
  String? key;
  String? name;
  String? email;
  String? password;
  String? lop;
  String? otp;
  String? add;
  String? phone;
  String? sex;
  String? linkImage;
  String? birthDate;
  String? role;

  UserAPIModel(
      {this.add,
      this.birthDate,
      this.email,
      this.key,
      this.lop,
      this.name,
      this.role,
      this.otp,
      this.linkImage,
      this.password,
      this.phone,
      this.sex});

  UserAPIModel.fromJson(Map<String, dynamic> json) {
    add = json['add'];
    birthDate = json['birthDate'];
    email = json['email'];
    key = json['key'];
    lop = json['lop'];
    role = json['role'];
    name = json['name'];
    otp = json['otp'];
    linkImage = json['linkImage'];
    password = json['password'];
    phone = json['phone'];
    sex = json['sex'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add'] = this.add;
    data['birthDate'] = this.birthDate;
    data['email'] = this.email;
    data['key'] = this.key;
    data['lop'] = this.lop;
    data['role'] = this.role;
    data['linkImage'] = this.linkImage;
    data['name'] = this.name;
    data['otp'] = this.otp;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    return data;
  }
}
