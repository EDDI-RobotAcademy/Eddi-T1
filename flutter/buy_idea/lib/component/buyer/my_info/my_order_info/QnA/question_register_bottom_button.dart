import 'package:buy_idea/api/spring_qna_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../pages/buyer/product/product_details_page.dart';

class QuestionRegisterBottomButton extends StatefulWidget {
  const QuestionRegisterBottomButton(
      {Key? key,
      required this.contentController,
      required this.productNo,
      required this.writer,
      required this.questionCategory,
      required this.questionTitle,
      required this.openStatus,
      required this.questionContent,
      })
      : super(key: key);
  final TextEditingController contentController;
  final int productNo;
  final String writer;
  final String questionCategory;
  final String questionTitle;
  final String questionContent;
  final bool openStatus;

  @override
  State<QuestionRegisterBottomButton> createState() => _QuestionRegisterBottomButtonState();
}

class _QuestionRegisterBottomButtonState extends State<QuestionRegisterBottomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (widget.contentController.text.isNotEmpty) {
            ///spring API 요청
            Question question = Question(widget.productNo, widget.writer, widget.questionCategory,
                widget.questionTitle, widget.questionContent, widget.openStatus);
            debugPrint('question : ' + question.toString());

            var questionRegister = SpringQnaApi().questionRegister(question);

            questionRegister.then((value) {
              if (value) {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white.withOpacity(0.7),
                        title: Text('📝️'),
                        content: Text(
                          '문의가 정상적으로 등록되었습니다.',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Get.back();
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProductDetailsPage(productNo: widget.productNo)))
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
                        Text('문의할 내용을 입력해 주세요.', textAlign: TextAlign.center),
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
          '문의 등록하기',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            fixedSize: Size(MediaQuery.of(context).size.width - 20, 60),
            primary: Color(0xff2F4F4F)));
  }
}
