class UserAPIReq {
  String? name;
  String? email;
  String? password;
  String? lop;
  String? otp;
  String? add;
  String? sex;
  String? birthDate;
  String? linkImage;
  String? phone;

  UserAPIReq(
      {this.name,
      this.email,
      this.password,
      this.lop,
      this.otp,
      this.add,
      this.sex,
      this.birthDate,
      this.linkImage,
      this.phone});

  UserAPIReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    lop = json['lop'];
    otp = json['otp'];
    add = json['add'];
    sex = json['sex'];
    birthDate = json['birthDate'];
    linkImage = json['linkImage'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['lop'] = this.lop;
    data['otp'] = this.otp;
    data['add'] = this.add;
    data['sex'] = this.sex;
    data['birthDate'] = this.birthDate;
    data['linkImage'] = this.linkImage;
    data['phone'] = this.phone;
    return data;
  }
}
