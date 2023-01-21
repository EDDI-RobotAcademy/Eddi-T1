import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../component/buyer/my_info/my_order_info/QnA/my_question_history_info.dart';
import 'ip_info.dart';

class SpringQnaApi {
  static var qnaDeleteResponse;

  Future<bool> questionRegister(Question question) async {
    debugPrint('questionRegister()');
    var body = json.encode(question);

    var response = await http.post(Uri.http(IpInfo.httpUri, '/qna/register'),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      return true;
    } else {
      throw Exception('orderRegister() 에러 발생');
    }
  }

  Future<List<MyQuestionHistoryInfo>> getQnaList(String nickname) async {
    debugPrint('getQnaList()');
    var body = json.encode(nickname);

    var response = await http.post(
        Uri.http(IpInfo.httpUri, '/qna/history-list/$nickname'),
        headers: {"Content-Type": "application/json"},
        body: body);

    var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    if (response.statusCode == 200) {
      List<MyQuestionHistoryInfo> quaList =
          data.map((list) => MyQuestionHistoryInfo.fromJson(list)).toList();

      debugPrint('통신 확인');
      return quaList;
    } else {
      throw Exception('orderRegister() 에러 발생');
    }
  }

  Future<List<MyQuestionHistoryInfo>> getQnaListByProductNo(
      int productNo) async {
    debugPrint('getQnaListByProductNo()');
    var body = json.encode(productNo);

    var response = await http.post(
        Uri.http(IpInfo.httpUri, '/qna/p-history-list/$productNo'),
        headers: {"Content-Type": "application/json"},
        body: body);

    var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    if (response.statusCode == 200) {
      List<MyQuestionHistoryInfo> quaList =
          data.map((list) => MyQuestionHistoryInfo.fromJson(list)).toList();

      debugPrint('통신 확인');
      return quaList;
    } else {
      throw Exception('orderRegister() 에러 발생');
    }
  }

  qnaDelete(int qnaNo) async {
    debugPrint("qnaDelete()");
    var body = json.encode(qnaNo);
    try {
      qnaDeleteResponse = await http.delete(
        Uri.http(IpInfo.httpUri, '/qna/delete/$qnaNo'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class Question {
  int productNo;
  String writer;
  String questionCategory;
  String questionTitle;
  String questionContent;
  bool openStatus;

  Question(this.productNo, this.writer, this.questionCategory,
      this.questionTitle, this.questionContent, this.openStatus);

  Map<String, dynamic> toJson() => {
        'productNo': productNo,
        'writer': writer,
        'questionCategory': questionCategory,
        'questionTitle': questionTitle,
        'questionContent': questionContent,
        'openStatus': openStatus
      };
}
