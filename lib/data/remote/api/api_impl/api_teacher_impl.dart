import 'dart:convert';
import 'dart:io';
import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:admin/data/remote/models/quiz_hw_res.dart';
import 'package:admin/data/remote/models/resukt_hw_req.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:admin/data/remote/models/user_res.dart';
import '../../../../application/cons/endpoint.dart';
import '../../../event_local/update_pre_now.dart';
import '../../../event_local/update_user_global.dart';
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
  Future<UserAPIModel?> getUserById(String id) async {
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

  @override
  Future<UserAPIModel?> getUserByEmail(String email) async {
    try {
      final url = "${endpoint}getUserByEmail?email=$email";
      final res = await http.get(Uri.parse(url), headers: requestHeaders);
      if (res.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(res.body);
        final userModel = UserAPIRes.fromJson(parsed).lItems!.first;
        UserEventLocal.updateUserGlobal(userModel);
        return userModel;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(res.body);
        final userModel = UserAPIRes.fromJson(parsed).lItems!.first;
        UserEventLocal.updateUserGlobal(userModel);

        return userModel;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<QuizHWAPIModel>?> getAllQuizHWByResultID(String resultID) async {
    try {
      final url = "${endpoint}getAllQuizHWByResultID?resultID=$resultID";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<QuizHWAPIModel>? result =
            QuizHWAPIResponse.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<QuizHWAPIModel>? result =
            QuizHWAPIResponse.fromJson(parsed).lItems;
        return result;
      }
    } on SocketException catch (_) {
      return Future.error('No network found');
    } catch (_) {
      return Future.error('Something occurred');
    }
  }

  @override
  Future<bool?> createUser(UserAPIModel data) async {
    try {
      const url = "${endpoint}create_user";
      final req = await http.post(Uri.parse(url),
          headers: requestHeaders, body: jsonEncode(data.toJson()));
      Map<String, dynamic> parsed = json.decode(req.body);
      if (req.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<UserAPIModel>?> getAllStudentByClass(String lop) async {
    try {
      final url = "${endpoint}getListUserByClass?lop=$lop";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<UserAPIModel>? result = UserAPIRes.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<UserAPIModel>? result = UserAPIRes.fromJson(parsed).lItems;
        return result;
      }
    } on SocketException catch (_) {
      return Future.error('No network found');
    } catch (_) {
      return Future.error('Something occurred');
    }
  }

  @override
  Future<UserAPIModel?> loginWithEmailAndPass(String email, String pass) async {
    try {
      final url =
          "${endpoint}getUserByEmailAndPassword?email=$email&password=$pass";
      final res = await http.get(Uri.parse(url), headers: requestHeaders);
      if (res.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(res.body);
        UserAPIModel userModel = UserAPIRes.fromJson(parsed).lItems!.first;
        if (userModel!.role == "teacher") {
          UserEventLocal.updateUserGlobal(userModel);
          return userModel;
        } else {
          return null;
        }
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(res.body);
        final userModel = UserAPIRes.fromJson(parsed).lItems!.first;
        UserEventLocal.updateUserGlobal(userModel);

        return userModel;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<ResultQuizHWAPIModel>?> getAllResultQuizHWByWeekAndLop(
      String week, String lop) async {
    try {
      final url =
          "${endpoint}getAllResultQuizHWByWeekAndClass?week=$week&lop=$lop";
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
  Future<List<ResultQuizHWAPIModel>?> getAllResultQuizHWByLop(
      String lop) async {
    try {
      final url = "${endpoint}getAllResultQuizHWByLop?lop=$lop";
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
  Future<PreHWResModel?> getPreHWByWeek(String week) async {
    try {
      final url = "${endpoint}getPreQuizHWByWeek?week=$week";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        PreHWResModel result = PreHWResAPI.fromJson(parsed).lItems!.first;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        PreHWResModel result = PreHWResModel.fromJson(parsed);
        return result;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> createResultHWForStudentNoJoin(
       ResultHWAPIReq data) async {
    try {
      const url = "${endpoint}create_result_quiz_for_student_No_join";
      final req = await http.post(Uri.parse(url),
          headers: requestHeaders, body: jsonEncode(data.toJson()));
      if (req.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
}
