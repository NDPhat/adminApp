
import '../../main.dart';
import '../local/models/user_global.dart';
import '../remote/models/user_res.dart';

class UserEventLocal {
  static void updateUserGlobal(UserAPIModel a) {
    instance.get<UserGlobal>().fullName = a.name;
    instance.get<UserGlobal>().id = a.key;
    instance.get<UserGlobal>().email = a.email;
    instance.get<UserGlobal>().lop = a.lop;
    instance.get<UserGlobal>().gender = a.sex;
    instance.get<UserGlobal>().role = a.role;
    instance.get<UserGlobal>().linkImage = a.linkImage;
    instance.get<UserGlobal>().otp = a.otp;
    instance.get<UserGlobal>().phone = a.phone;
    instance.get<UserGlobal>().address = a.add;
    instance.get<UserGlobal>().dateOfBirth = a.birthDate;
    instance.get<UserGlobal>().password = a.password;
  }
}
