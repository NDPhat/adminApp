

import 'package:admin/data/remote/models/pre_hw_req.dart';

import '../../models/pre_hw_res.dart';

abstract class TeacherAPIRepo {
  Future<int?> createPreHW(PreQuizHWReqAPI data);
  Future<bool?> updatePreHW(PreQuizHWReqAPI data,String key);
  Future<List<PreHWResModel>?> getALlPreHW();


}
