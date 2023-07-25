class UserAPIReq {
  String? name;
  String? email;
  String? password;
  String? lop;
  String? otp;
  String? add;
  String? deleteHash;
  String? phone;
  String? sex;
  String? linkImage;
  String? birthDate;
  String? role;

  UserAPIReq(
      {this.name,
        this.email,
        this.password,
        this.lop,
        this.otp,
        this.add,
        this.deleteHash,
        this.phone,
        this.sex,
        this.linkImage,
        this.birthDate,
        this.role});

  UserAPIReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    lop = json['lop'];
    otp = json['otp'];
    add = json['add'];
    deleteHash = json['deleteHash'];
    phone = json['phone'];
    sex = json['sex'];
    linkImage = json['linkImage'];
    birthDate = json['birthDate'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['lop'] = this.lop;
    data['otp'] = this.otp;
    data['add'] = this.add;
    data['deleteHash'] = this.deleteHash;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    data['linkImage'] = this.linkImage;
    data['birthDate'] = this.birthDate;
    data['role'] = this.role;
    return data;
  }
}
