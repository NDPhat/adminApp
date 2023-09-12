import 'package:admin/data/remote/models/pre_hw_res.dart';

import '../../main.dart';
import '../local/models/pre_global.dart';

class PreEventLocal {
  static void updatePreGlobal(PreHWAPIModel a) {
    instance.get<PreGlobal>().key = a.key;
    instance.get<PreGlobal>().sign = a.sign;
    instance.get<PreGlobal>().numQ = a.numQ;
    instance.get<PreGlobal>().sNum = a.sNum;
    instance.get<PreGlobal>().eNum = a.eNum;
    instance.get<PreGlobal>().dstart = a.dstart;
    instance.get<PreGlobal>().dend = a.dend;
    instance.get<PreGlobal>().status = a.status;
    instance.get<PreGlobal>().week = a.week;
    instance.get<PreGlobal>().color = a.color;
  }
}
