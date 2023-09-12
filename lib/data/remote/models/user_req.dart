class UserAPIReq {
  String? fullName;
  String? email;
  String? password;
  String? lop;
  String? otpCode;
  String? address;
  String? deleteHash;
  String? phone;
  String? sex;
  String? linkImage;
  String? birthDay;
  String? role;

  UserAPIReq(
      {this.fullName,
      this.email,
      this.password,
      this.lop,
      this.otpCode,
      this.address,
      this.deleteHash,
      this.phone,
      this.sex,
      this.linkImage,
      this.birthDay,
      this.role});

  UserAPIReq.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    password = json['password'];
    lop = json['lop'];
    otpCode = json['otpCode'];
    address = json['address'];
    deleteHash = json['deleteHash'];
    phone = json['phone'];
    sex = json['sex'];
    linkImage = json['linkImage'];
    birthDay = json['birthDay'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['lop'] = this.lop;
    data['otpCode'] = this.otpCode;
    data['address'] = this.address;
    data['deleteHash'] = this.deleteHash;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    data['linkImage'] = this.linkImage;
    data['birthDay'] = this.birthDay;
    data['role'] = this.role;
    return data;
  }
}
