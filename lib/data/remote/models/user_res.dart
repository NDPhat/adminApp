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
  String? add;
  String? birthDate;
  String? email;
  String? key;
  String? linkImage;
  String? lop;
  String? name;
  String ? otp;
  String? password;
  String? phone;
  String? role;
  String? sex;

  UserAPIModel(
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

  UserAPIModel.fromJson(Map<String, dynamic> json) {
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
