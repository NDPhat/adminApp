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
  String? address;
  String? birthDay;
  String? deleteHash;
  String? email;
  String? fullName;
  String? key;
  String? linkImage;
  String? lop;
  String? otpCode;
  String? password;
  String? phone;
  String? role;
  String? sex;

  UserAPIModel(
      {this.address,
        this.birthDay,
        this.deleteHash,
        this.email,
        this.fullName,
        this.key,
        this.linkImage,
        this.lop,
        this.otpCode,
        this.password,
        this.phone,
        this.role,
        this.sex});

  UserAPIModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    birthDay = json['birthDay'];
    deleteHash = json['deleteHash'];
    email = json['email'];
    fullName = json['fullName'];
    key = json['key'];
    linkImage = json['linkImage'];
    lop = json['lop'];
    otpCode = json['otpCode'];
    password = json['password'];
    phone = json['phone'];
    role = json['role'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['birthDay'] = this.birthDay;
    data['deleteHash'] = this.deleteHash;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['key'] = this.key;
    data['linkImage'] = this.linkImage;
    data['lop'] = this.lop;
    data['otpCode'] = this.otpCode;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['sex'] = this.sex;
    return data;
  }
}
