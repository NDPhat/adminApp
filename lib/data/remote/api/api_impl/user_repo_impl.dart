import 'dart:convert';
import 'dart:io';
import 'package:admin/data/remote/models/user_req.dart';
import 'package:admin/data/remote/models/user_res.dart';
import '../../../../application/cons/endpoint.dart';
import '../../../event_local/update_user_global.dart';
import 'package:http/http.dart' as http;

import '../../models/user_res_pagi.dart';
import '../api/user_repo.dart';

class UserAPIRepoImpl extends UserAPIRepo {
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
  Future<bool?> createUser(UserAPIModel data) async {
    try {
      const url = "${endpoint}create_user";
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
        final userModel = UserAPIRes.fromJson(parsed).lItems!.first;
        if (userModel.role == "teacher") {
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
  Future<bool?> updateProfileUser(String keyId, UserAPIReq user) async {
    try {
      final url = "${endpoint}updateUserById?id=$keyId";
      final res = await http.patch(Uri.parse(url),
          headers: requestHeaders, body: jsonEncode(user.toJson()));
      if (res.statusCode == 200) {
        return true;
      } else {
        // log(req.body);
        return false;
      }
    } on SocketException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<UserAPIResPagi?> getAllStudentByClassWithPagi(
      String lop, int page) async {
    try {
      final url =
          "${endpoint}getListUserByClassPagination?lop=$lop&page_num=$page&page_size=5";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        UserAPIResPagi? result = UserAPIResPagi.fromJson(parsed);
        return result;
      } else {
        Map<String, dynamic> parsed = json.decode(req.body);
        UserAPIResPagi? result = UserAPIResPagi.fromJson(parsed);
        return result;
      }
    } on SocketException catch (_) {
      return Future.error('No network found');
    } catch (_) {
      return Future.error('Something occurred');
    }
  }

  @override
  Future<bool?> deleteUserById(String userID) async {
    try {
      final url = "${endpoint}updateUserById?id=$userID";
      final req = await http.delete(Uri.parse(url), headers: requestHeaders);
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
