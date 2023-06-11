import 'dart:convert';
import 'dart:io';
import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:admin/data/remote/models/user_res.dart';
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
      print(req.statusCode);
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

  @override
  Future<List<PreHWResModel>?> getALlDonePreHW() async {
    try {
      const url = "${endpoint}getAllDonePreHW";
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
  Future<List<PreHWResModel>?> getOnGoingPreHW() async {
    try {
      const url = "${endpoint}getPreWStatusOnGoing";
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
  Future<List<ResultQuizHWAPIModel>?> getAllResultQuizHWByWeek(
      String week) async {
    try {
      final url = "${endpoint}getAllResultQuizHWByWeek?week=$week";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<ResultQuizHWAPIModel>? result =
            ResultQuizHWAPIResponse.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<ResultQuizHWAPIModel>? result =
            ResultQuizHWAPIResponse.fromJson(parsed).lItems;
        return result;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<UserAPIModel?> getUserStudentById(String id) async {
    try {
      final url = "${endpoint}getUserById?uId=$id";
      final res = await http.get(Uri.parse(url), headers: requestHeaders);
      if (res.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(res.body);
        final userModel = UserAPIModel.fromJson(parsed);
        return userModel;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(res.body);
        final userModel = UserAPIModel.fromJson(parsed);
        return userModel;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }
}
