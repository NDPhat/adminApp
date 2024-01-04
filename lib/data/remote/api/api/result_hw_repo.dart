import 'package:admin/data/remote/models/quiz_hw_res.dart';
import '../../models/result_hw_req.dart';
import '../../models/result_hw_res.dart';
import '../../models/result_hw_res_pagi.dart';

abstract class ResultHWAPIRepo {
  Future<List<ResultHWAPIModel>?> getAllResultQuizHWByWeek(String week);
  Future<List<ResultHWAPIModel>?> getAllResultQuizHWByWeekAndLop(
      String week, String lop,String key);
  Future<List<ResultHWAPIModel>?> getAllResultQuizHWByLopAndDoneWeek(String lop);
  Future<ResultHWAPIResPagi?> getAllResultQuizHWByWeekAndLopWithPagi(
      String week, String lop, int page);
  Future<List<ResultHWAPIModel>?> getAllResultQuizHWByLop(String lop);
  Future<List<QuizHWAPIModel>?> getAllQuizHWByResultID(String resultID);
  Future<bool?> createResultHWForStudentNoJoin(ResultHWAPIReq data);
  Future<bool?> updateStatusMarkScore(ResultHWAPIModel data);
}
