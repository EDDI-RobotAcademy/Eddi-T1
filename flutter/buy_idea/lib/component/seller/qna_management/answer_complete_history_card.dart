import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../api/seller/spring_seller_qna_api.dart';
import '../../../pages/seller/qna_management/qna_management_page.dart';
import '../../common/common_alert_dialog.dart';
import '../../common/yes_or_no_alert_dialog.dart';

class AnswerCompleteHistoryCard extends StatefulWidget {
  const AnswerCompleteHistoryCard(
      {Key? key,
      required this.productNo,
      required this.title,
      required this.writer,
      required this.nickname,
      required this.questionCategory,
      required this.questionTitle,
      required this.questionContent,
      required this.answer,
      required this.answerStatus,
      required this.regDate,
      required this.updDate,
      required this.openStatus,
      required this.qnaNo})
      : super(key: key);
  final int productNo;
  final int qnaNo;
  final String title;
  final String writer;
  final String nickname;
  final String questionCategory;
  final String questionTitle;
  final String questionContent;
  final String answer;
  final String answerStatus;
  final String regDate;
  final String updDate;
  final bool openStatus;

  @override
  State<AnswerCompleteHistoryCard> createState() =>
      _AnswerCompleteHistoryCardState();
}

class _AnswerCompleteHistoryCardState extends State<AnswerCompleteHistoryCard> {

  deleteAction() async {
    await SpringSellerQnaApi().deleteAnswer(widget.qnaNo);
    if (SpringSellerQnaApi.deleteAnswerResponse.statusCode == 200) {
      debugPrint('문의글 삭제 성공');
      _deleteSuccessShowDialog();
    }else {
      _deleteFailShowDialog();
      debugPrint('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime parseRegDate = DateTime.parse(widget.regDate);
    DateTime parseUpdDate = DateTime.parse(widget.updDate);
    String regDateFormat = DateFormat('yyyy-MM-dd').format(parseRegDate);
    String updDateFormat = DateFormat('yyyy-MM-dd').format(parseUpdDate);

    return Padding(
      padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  /// 공개여부 따라 아이콘 띄우기
                  if (widget.openStatus)
                    Icon(Icons.lock_open, color: Colors.grey, size: 20)
                  else
                    Icon(Icons.lock, color: Colors.grey, size: 20),
                  SizedBox(width: 4.0),

                  /// 답변 상태 따라 텍스트 띄우기
                  if (widget.answerStatus == '답변 대기')
                    const Text(
                      '답변 대기',
                      style: TextStyle(color: Colors.grey),
                    )
                  else if (widget.answerStatus == '답변 완료')
                    const Text('답변 완료',
                        style: TextStyle(
                            color: Color(0xFFDAA520),
                            fontWeight: FontWeight.bold)),
                  Text(' | ${widget.questionCategory}'),
                  Expanded(child: SizedBox()),
                  Text('${widget.writer} | ',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(regDateFormat,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(width: 4.0),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Q.',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F4F4F)),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 320.0,
                    child: Text(
                      widget.questionContent,
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),

              /// 답변 상태에 따라 띄우기
              if (widget.answerStatus == '답변 완료')
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'A.',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFDAA520)),
                        ),
                        SizedBox(width: 10.0),
                        Container(
                          width: 320.0,
                          child: Text(
                            widget.answer,
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        SizedBox(width: 10.0),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('${widget.nickname} | ',
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                        Text(updDateFormat,
                            style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Container(
                        width: 300.0,
                        child: TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return YesOrNoAlertDialog(
                                      title: '🗑️',
                                      content: '답변을 삭제하시겠습니까?',
                                      yesButtonPressed: () {
                                        Get.back();
                                        /// 삭제 요청
                                        deleteAction();
                                      },
                                      noButtonPressed: () {
                                        Get.back();
                                      },
                                    );
                                  });
                            },
                            child: const Text('답변 삭제',
                                style: TextStyle(
                                    color: Color(0xFFDAA520), fontSize: 14)),
                            style: ElevatedButton.styleFrom(
                                side: const BorderSide(
                                    color: Color(0xFFDAA520), width: 1.0),
                                elevation: 0,
                                primary: Colors.white))),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _deleteSuccessShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
              title: "🙆‍♀️",
              content: '삭제되었습니다.',
              onCustomButtonPressed: () {
                Get.back();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QnaManagementPage()))
                    .then((value) => setState(() {}));
              });
        });
  }

  void _deleteFailShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
              title: "⚠️",
              content: '죄송합니다. \n서버가 불안정하여 삭제가 실패했습니다.',
              onCustomButtonPressed: () {
                Get.back();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QnaManagementPage()))
                    .then((value) => setState(() {}));
              });
        });
  }
}
