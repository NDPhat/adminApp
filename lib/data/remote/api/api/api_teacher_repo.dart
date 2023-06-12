import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/data/remote/models/quiz_hw_res.dart';
import 'package:admin/data/remote/models/user_res.dart';

import '../../models/pre_hw_res.dart';
import '../../models/result_hw_res.dart';

abstract class TeacherAPIRepo {
  Future<bool?> createUser(UserAPIModel data);
  Future<List<UserAPIModel>?> getAllStudentByClass(String lop);
  Future<UserAPIModel?> getUserStudentById(String id);
  Future<int?> createPreHW(PreQuizHWReqAPI data);
  Future<bool?> updatePreHW(PreQuizHWReqAPI data, String key);
  Future<List<ResultQuizHWAPIModel>?> getAllResultQuizHWByWeek(String week);
  Future<List<PreHWResModel>?> getALlDonePreHW();
  Future<List<PreHWResModel>?> getOnGoingPreHW();
  Future<List<QuizHWAPIModel>?> getAllQuizHWByResultID(String resultID);
}
