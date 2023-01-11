import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../component/buyer/my_info/my_order_info/QnA/my_question_history_info.dart';

class SpringQnaApi {
  static const String httpUri = '192.168.0.8:8888';

  Future<bool> questionRegister(Question question) async {
    debugPrint('questionRegister()');
    var body = json.encode(question);

    var response = await http.post(Uri.http(httpUri, '/qna/register'),
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

    var response = await http.post(Uri.http(httpUri, '/qna/history-list/$nickname'),
        headers: {"Content-Type": "application/json"}, body: body);

    var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    if (response.statusCode == 200) {

      List<MyQuestionHistoryInfo> quaList = data
          .map((list) => MyQuestionHistoryInfo.fromJson(list))
          .toList();

      debugPrint('통신 확인');
      return quaList;
    } else {
      throw Exception('orderRegister() 에러 발생');
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
