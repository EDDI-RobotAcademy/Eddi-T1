import 'package:flutter/material.dart';

class AnswerRegisterBottomButton extends StatefulWidget {
  const AnswerRegisterBottomButton(
      {Key? key,
        required this.qnaNo,
        required this.contentController, required this.answerContent,

      })
      : super(key: key);
  final int qnaNo;
  final String answerContent;
  final TextEditingController contentController;

  @override
  State<AnswerRegisterBottomButton> createState() => _AnswerRegisterBottomButtonState();
}

class _AnswerRegisterBottomButtonState extends State<AnswerRegisterBottomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
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
