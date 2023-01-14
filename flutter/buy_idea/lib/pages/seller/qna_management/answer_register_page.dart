import 'package:flutter/material.dart';

import '../../../../../component/buyer/app_bar/title_top_bar.dart';
import '../../../component/seller/qna_management/answer_register_form.dart';

class AnswerRegisterPage extends StatefulWidget {
  const AnswerRegisterPage(
      {Key? key,
      required this.qnaNo,
      required this.title,
      required this.writer,
      required this.openStatus,
      required this.questionCategory,
      required this.questionContent,
      required this.answerStatus,
      required this.regDate,
      required this.nickname})
      : super(key: key);
  final int qnaNo;
  final String title;
  final String writer;
  final String nickname;
  final bool openStatus;
  final String questionCategory;
  final String questionContent;
  final String answerStatus;
  final String regDate;

  @override
  State<AnswerRegisterPage> createState() => _AnswerRegisterPageState();
}

class _AnswerRegisterPageState extends State<AnswerRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleTopBar(titleText: '답변하기'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('📬  ${widget.nickname}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2F4F4F))),
                    Text('의',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 32.0),
                    Text('답변을 기다리는 문의글입니다.',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 30.0),
                AnswerRegisterForm(
                  qnaNo: widget.qnaNo,
                  title: widget.title,
                  writer: widget.writer,
                  questionCategory: widget.questionCategory,
                  questionContent: widget.questionContent,
                  answerStatus: widget.answerStatus,
                  regDate: widget.regDate,
                  openStatus: widget.openStatus,
                ),
              ],
            ),
          ),
        ));
  }
}
