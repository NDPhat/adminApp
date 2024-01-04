import 'dart:convert';
import 'dart:io';
import 'package:admin/data/remote/api/api/pre_hw_repo.dart';
import 'package:admin/data/remote/models/pre_hw_res.dart';
import 'package:admin/data/remote/models/quiz_hw_res.dart';
import 'package:admin/data/remote/models/result_hw_res.dart';
import 'package:admin/main.dart';
import '../../../../application/cons/endpoint.dart';
import '../../models/result_hw_req.dart';
import 'package:http/http.dart' as http;

import '../../models/result_hw_res_pagi.dart';
import '../api/result_hw_repo.dart';

class ResultHWAPIRepoImpl extends ResultHWAPIRepo {
  @override
  Future<List<ResultHWAPIModel>?> getAllResultQuizHWByWeek(String week) async {
    try {
      final url = "${endpoint}getAllResultQuizHWByWeek?week=$week";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<ResultHWAPIModel>? result = ResultHWAPIRes.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<ResultHWAPIModel>? result = ResultHWAPIRes.fromJson(parsed).lItems;
        return result;
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
        List<QuizHWAPIModel>? result = QuizHWAPIRes.fromJson(parsed).lItems;
        return result;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<QuizHWAPIModel>? result = QuizHWAPIRes.fromJson(parsed).lItems;
        return result;
      }
    } on SocketException catch (_) {
      return Future.error('No network found');
    } catch (_) {
      return Future.error('Something occurred');
    }
  }

  @override
  Future<List<ResultHWAPIModel>?> getAllResultQuizHWByWeekAndLop(
      String week, String lop, String key) async {
    try {
      final url =
          "${endpoint}getAllResultQuizHWByWeekAndClass?week=$week&lop=$lop";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<ResultHWAPIModel>? result = ResultHWAPIRes.fromJson(parsed).lItems;
        if (key != "mark") {
          List<ResultHWAPIModel>? data = [];
          result!.forEach((element) {
            if (element.numQ == 11) {
              data.add(element);
            }
          });
          return data;
        } else {
          return result;
        }
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<ResultHWAPIModel>? result = ResultHWAPIRes.fromJson(parsed).lItems;
        List<ResultHWAPIModel>? data = [];
        result!.forEach((element) {
          if (element.numQ == 11) {
            data.add(element);
          }
        });
        return data;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<List<ResultHWAPIModel>?> getAllResultQuizHWByLop(String lop) async {
    try {

      final url = "${endpoint}getAllResultQuizHWByLop?lop=$lop";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        List<ResultHWAPIModel>? result = ResultHWAPIRes.fromJson(parsed).lItems;
        List<ResultHWAPIModel>? data = [];
        result!.forEach((element) {
          if (element.numQ == 11) {
            data.add(element);
          }
        });
        return data;
      } else {
        // log(req.body);
        Map<String, dynamic> parsed = json.decode(req.body);
        List<ResultHWAPIModel>? result = ResultHWAPIRes.fromJson(parsed).lItems;
        List<ResultHWAPIModel>? data = [];
        result!.forEach((element) {
          if (element.numQ == 11) {
            data.add(element);
          }
        });
        return data;
      }
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> createResultHWForStudentNoJoin(ResultHWAPIReq data) async {
    try {
      const url = "${endpoint}createResultHWForNoJoin";
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
  Future<ResultHWAPIResPagi?> getAllResultQuizHWByWeekAndLopWithPagi(
      String week, String lop, int page) async {
    try {
      final url =
          "${endpoint}getAllResultQuizHWByWeekAndClassWithPagi?week=$week&lop=$lop&page_num=$page&page_size=5";
      final req = await http.get(Uri.parse(url), headers: requestHeaders);
      if (req.statusCode == 200) {
        Map<String, dynamic> parsed = json.decode(req.body);
        ResultHWAPIResPagi? result = ResultHWAPIResPagi.fromJson(parsed);
        return result;
      } else {
        Map<String, dynamic> parsed = json.decode(req.body);
        ResultHWAPIResPagi? result = ResultHWAPIResPagi.fromJson(parsed);
        return result;
      }
    } on SocketException catch (_) {
      return Future.error('No network found');
    } catch (_) {
      return Future.error('Something occurred');
    }
  }

  @override
  Future<List<ResultHWAPIModel>?> getAllResultQuizHWByLopAndDoneWeek(
      String lop) async {
    try {
      List<PreHWAPIModel>? preHW =
          await instance.get<PreHWAPIRepo>().getALlDonePreHW(lop);
      List<ResultHWAPIModel>? totalList = [];
      preHW!.forEach((element) async {
        final url =
            "${endpoint}getAllResultQuizHWByWeekAndClass?week=${element.week}&lop=$lop";
        final req = await http.get(Uri.parse(url), headers: requestHeaders);
        if (req.statusCode == 200) {
          Map<String, dynamic> parsed = json.decode(req.body);
          List<ResultHWAPIModel>? result =
              ResultHWAPIRes.fromJson(parsed).lItems;
          result!.forEach((element) {
            if (element.numQ == 11) {
              totalList.add(element);
            }
          });
        } else {
          // log(req.body);
          Map<String, dynamic> parsed = json.decode(req.body);
          List<ResultHWAPIModel>? result =
              ResultHWAPIRes.fromJson(parsed).lItems;
          result!.forEach((element) {
            if (element.numQ == 11) {
              totalList.add(element);
            }
          });
        }
      });
      return totalList;
    } on SocketException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<bool?> updateStatusMarkScore(ResultHWAPIModel data) async {
    try {
      final url = "${endpoint}updateResultQuizHWById?id=${data.key!}";
      final res = await http.patch(Uri.parse(url),
          headers: requestHeaders, body: jsonEncode(data.toJson()));
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
}
