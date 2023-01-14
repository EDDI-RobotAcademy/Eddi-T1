import 'package:buy_idea/pages/seller/qna_management/qna_management_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/seller/spring_seller_qna_api.dart';

class AnswerRegisterBottomButton extends StatefulWidget {
  const AnswerRegisterBottomButton({
    Key? key,
    required this.qnaNo,
    required this.contentController,
    required this.answerContent,
  }) : super(key: key);
  final int qnaNo;
  final String answerContent;
  final TextEditingController contentController;

  @override
  State<AnswerRegisterBottomButton> createState() =>
      _AnswerRegisterBottomButtonState();
}

class _AnswerRegisterBottomButtonState
    extends State<AnswerRegisterBottomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (widget.contentController.text.isNotEmpty) {
            ///spring API 요청
            Answer answer = Answer(widget.qnaNo, widget.answerContent);
            debugPrint('answer : ' + answer.toString());

            var answerRegister = SpringSellerQnaApi().answerRegister(answer);

            answerRegister.then((value) {
              if (value) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        title: Text('📝️'),
                        content: Text(
                          '답변이 정상적으로 등록되었습니다.',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                                Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QnaManagementPage()))
                                    .then((value) => setState(() {}));
                              },
                              child: Text('확인'))
                        ],
                      );
                    });
              }
            });
          } else {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white.withOpacity(0.7),
                    title: Text('⚠️'),
                    content:
                        Text('답변 내용을 입력해 주세요.', textAlign: TextAlign.center),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text('확인'))
                    ],
                  );
                });
          }
        },
        child: Text(
          '답변 등록',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            fixedSize: Size(MediaQuery.of(context).size.width - 20, 60),
            primary: Color(0xFFDAA520)));
  }
}
