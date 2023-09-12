import 'dart:convert';
import 'dart:io';
import 'package:admin/data/remote/models/pre_hw_req.dart';
import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:admin/data/remote/models/pre_hw_res_pagi.dart';
import 'package:path/path.dart';
import '../../../../application/cons/endpoint.dart';
import 'package:http/http.dart' as http;

import '../api/pre_hw_repo.dart';

class PreHWAPIImpl extends PreHWAPIRepo {
  @override
  Future<int?> createPreHW(PreHWAPIReq data) async {
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
  Future<List<PreHWAPIModel>?> getALlPreHW() async {
    try {
      const url = "${endpoint}getAllPreQuizHW";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<PreHWAPIModel>? result = PreHWAPIRes.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<PreHWAPIModel>? result = PreHWAPIRes.fromJson(parsed).lItems;
        return result;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> updatePreHW(PreHWAPIReq data, String key) async {
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
  Future<List<PreHWAPIModel>?> getALlDonePreHW(String lop) async {
    try {
      const url = "${endpoint}getAllDonePreHWByClass?lop=lop";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<PreHWAPIModel>? result = PreHWAPIRes.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<PreHWAPIModel>? result = PreHWAPIRes.fromJson(parsed).lItems;
        return result;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<PreHWAPIModel>?> getOnGoingPreHW(String lop) async {
    try {
      final url = "${endpoint}getPreWStatusOnGoingByClass?lop=$lop";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<PreHWAPIModel>? result = PreHWAPIRes.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<PreHWAPIModel>? result = PreHWAPIRes.fromJson(parsed).lItems;
        return result;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<PreHWAPIResPagi?> getALlDonePreHWWithPagi(int page, String lop) async {
    try {
      final url =
          "${endpoint}getAllDonePreHWWithPagiByClass?lop=$lop&?page_num=$page&page_size=5";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        PreHWAPIResPagi? result = PreHWAPIResPagi.fromJson(parsed);
        return result;
      } else {
        Map<String, dynamic> parsed = json.decode(req.body);
        PreHWAPIResPagi? result = PreHWAPIResPagi.fromJson(parsed);
        return result;
      }
    } on SocketException catch (_) {
      return Future.error('No network found');
    } catch (_) {
      return Future.error('Something occurred');
    }
  }

  @override
  Future<PreHWAPIModel?> getPreHWByWeek(String week) async {
    try {
      final url = "${endpoint}getPreQuizHWByWeek?week=$week";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        PreHWAPIModel result = PreHWAPIRes.fromJson(parsed).lItems!.first;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        PreHWAPIModel result = PreHWAPIModel.fromJson(parsed);
        return result;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }
}
