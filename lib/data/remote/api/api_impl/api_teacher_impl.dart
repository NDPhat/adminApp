import 'dart:convert';
import 'dart:io';
import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/data/remote/models/pre_hw_res.dart';
import '../../../../application/cons/endpoint.dart';
import '../../../event_local/update_pre_now.dart';
import '../api/api_teacher_repo.dart';
import 'package:http/http.dart' as http;

class TeacherAPIImpl extends TeacherAPIRepo {
  @override
  Future<int?> createPreHW(PreQuizHWReqAPI data) async {
    try {
      const url = "${endpoint}create_prequiz_hw";
      final req = await http.post(Uri.parse(url),
          headers: requestHeaders, body: jsonEncode(data.toJson()));
      Map<String, dynamic> parsed = json.decode(req.body);
      if (req.statusCode == 200) {
        return 0;
      } else if (req.statusCode == 404 &&
          (parsed["message"] == "quiz da ton tai")) {
        // log(req.body);
        return 1;
      }
    } on SocketException catch (_) {
      return Future.error('No network found');
    } catch (_) {
      return Future.error('Something occurred');
    }
  }

  @override
  Future<List<PreHWResModel>?> getALlPreHW() async {
    try {
      const url = "${endpoint}getAllPreQuizHW";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<PreHWResModel>? result = PreHWResAPI.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<PreHWResModel>? result = PreHWResAPI.fromJson(parsed).lItems;
        return result;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> updatePreHW(PreQuizHWReqAPI data, String key) async {
    try {
      final url = "${endpoint}updatePreHWByID?key=$key";
      final req = await http.patch(Uri.parse(url),
          headers: requestHeaders, body: jsonEncode(data.toJson()));
      if (req.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }
}
