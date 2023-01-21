import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../component/buyer/my_info/my_order_info/QnA/my_question_history_info.dart';
import '../ip_info.dart';

class SpringSellerQnaApi {

  static var deleteAnswerResponse;

  Future<List<MyQuestionHistoryInfo>> getAnswerStatusList(
      AnswerStatusRequest request) async {
    debugPrint('getAnswerStatusList()');
    var body = json.encode(request);

    var response = await http.post(Uri.http(IpInfo.httpUri, '/qna/answer-status-list'),
        headers: {"Content-Type": "application/json"}, body: body);

    var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    if (response.statusCode == 200) {
      List<MyQuestionHistoryInfo> quaList =
          data.map((list) => MyQuestionHistoryInfo.fromJson(list)).toList();

      debugPrint('통신 확인');
      return quaList;
    } else {
      throw Exception('getAnswerStatusList() 에러 발생');
    }
  }

  Future<bool> answerRegister(Answer answer) async {
    debugPrint('answerRegister()');
    var body = json.encode(answer);

    var response = await http.post(Uri.http(IpInfo.httpUri, '/qna/answer-register'),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      return true;
    } else {
      throw Exception('answerRegister() 에러 발생');
    }
  }

  deleteAnswer(int qnaNo) async {
    debugPrint('deleteAnswer()');

    deleteAnswerResponse = await http.post(
        Uri.http(IpInfo.httpUri, '/qna/delete-answer/$qnaNo'),
        headers: {"Content-Type": "application/json"});

    if (deleteAnswerResponse.statusCode == 200) {
      debugPrint('통신 확인');
    } else {
      throw Exception('deleteAnswer() 에러 발생');
    }
  }
}

class AnswerStatusRequest {
  String nickname;
  String answerStatus;

  AnswerStatusRequest(this.nickname, this.answerStatus);

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'answerStatus': answerStatus,
      };
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

class Answer {
  int qnaNo;
  String answer;

  Answer(this.qnaNo, this.answer);

  Map<String, dynamic> toJson() => {
        'qnaNo': qnaNo,
        'answer': answer,
      };
}
