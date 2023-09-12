
import 'package:admin/data/remote/models/user_res.dart';
import '../../models/user_req.dart';
import '../../models/user_res_pagi.dart';

abstract class UserAPIRepo {
  Future<bool?> createUser(UserAPIModel data);
  Future<bool?> deleteUserById(String userID);
  Future<UserAPIModel?> loginWithEmailAndPass(String email, String pass);
  Future<List<UserAPIModel>?> getAllStudentByClass(String lop);
  Future<UserAPIResPagi?> getAllStudentByClassWithPagi(String lop, int page);
  Future<UserAPIModel?> getUserById(String id);
  Future<UserAPIModel?> getUserByEmail(String email);
  Future<bool?> updateProfileUser(String keyId, UserAPIReq user);
}
