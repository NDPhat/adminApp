import 'package:admin/data/remote/models/pre_hw_req.dart';
import '../../models/pre_hw_res.dart';
import '../../models/pre_hw_res_pagi.dart';

abstract class PreHWAPIRepo {
  Future<int?> createPreHW(PreHWAPIReq data);
  Future<bool?> updatePreHW(PreHWAPIReq data, String key);
  Future<List<PreHWAPIModel>?> getALlDonePreHW(String lop);
  Future<PreHWAPIResPagi?> getALlDonePreHWWithPagi(int page, String lop);
  Future<PreHWAPIModel?> getPreHWByWeek(String week);
  Future<List<PreHWAPIModel>?> getOnGoingPreHW(String lop);
}
