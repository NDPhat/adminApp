import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/data/remote/models/quiz_hw_res.dart';
import 'package:admin/data/remote/models/user_res.dart';
import '../../models/pre_hw_res.dart';
import '../../models/result_hw_pagi_res.dart';
import '../../models/result_hw_req.dart';
import '../../models/result_hw_res.dart';
import '../../models/user_req.dart';
import '../../models/user_res_with_pagi.dart';

abstract class TeacherAPIRepo {
  Future<bool?> createUser(UserAPIModel data);
  Future<UserAPIModel?> loginWithEmailAndPass(String email, String pass);
  Future<List<UserAPIModel>?> getAllStudentByClass(String lop);
  Future<UserResPagiAPI?> getAllStudentByClassWithPagi(String lop, int page);
  Future<UserAPIModel?> getUserById(String id);
  Future<UserAPIModel?> getUserByEmail(String email);
  Future<int?> createPreHW(PreQuizHWReqAPI data);
  Future<bool?> updatePreHW(PreQuizHWReqAPI data, String key);
  Future<List<ResultQuizHWAPIModel>?> getAllResultQuizHWByWeek(String week);
  Future<List<ResultQuizHWAPIModel>?> getAllResultQuizHWByWeekAndLop(
      String week, String lop);
  Future<ResultHWPagiAPI?> getAllResultQuizHWByWeekAndLopWithPagi(
      String week, String lop,int page);
  Future<List<ResultQuizHWAPIModel>?> getAllResultQuizHWByLop(String lop);
  Future<List<PreHWResModel>?> getALlDonePreHW();
  Future<PreHWResModel?> getPreHWByWeek(String week);
  Future<List<PreHWResModel>?> getOnGoingPreHW();
  Future<List<QuizHWAPIModel>?> getAllQuizHWByResultID(String resultID);
  Future<bool?> createResultHWForStudentNoJoin(ResultHWAPIReq data);
  Future<bool?> updateProfileUser(String keyId, UserAPIReq user);
}
