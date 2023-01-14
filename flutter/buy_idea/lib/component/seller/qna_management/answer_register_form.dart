import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import 'AnswerRegisterBottomButton.dart';

class AnswerRegisterForm extends StatefulWidget {
  const AnswerRegisterForm(
      {Key? key,
      required this.qnaNo,
      required this.title,
      required this.writer,
      required this.questionCategory,
      required this.questionContent,
      required this.answerStatus,
      required this.regDate,
      required this.openStatus})
      : super(key: key);
  final int qnaNo;
  final String title;
  final String writer;
  final bool openStatus;
  final String questionCategory;
  final String questionContent;
  final String answerStatus;
  final String regDate;

  @override
  State<AnswerRegisterForm> createState() => _AnswerRegisterFormState();
}

class _AnswerRegisterFormState extends State<AnswerRegisterForm> {
  TextEditingController _contentController = TextEditingController();
  static const storage = FlutterSecureStorage();
  String textValue = '';
  dynamic nickname = '';
  final int maxLength = 500;

  @override
  void initState() {
    _asyncMethod();
    super.initState();
  }

  _asyncMethod() async {
    nickname = await storage.read(key: 'nickname');
  }

  @override
  Widget build(BuildContext context) {
    DateTime parseRegDate = DateTime.parse(widget.regDate);
    String regDateFormat = DateFormat('yyyy-MM-dd').format(parseRegDate);

    return Column(
      children: [
        Row(
          children: [
            Text('[${widget.questionCategory}]',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFFDAA520))),
            SizedBox(width: 10.0),
            Container(
              width: 250.0,
              child: Text(widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
        SizedBox(height: 20.0),
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
                      color: Color(0xFFDAA520), fontWeight: FontWeight.bold)),
            Expanded(child: SizedBox()),
            Text('${widget.writer} | ',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(regDateFormat,
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            SizedBox(width: 4.0),
          ],
        ),
        SizedBox(height: 4.0),
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
            SingleChildScrollView(
              child: Container(
                width: 320.0,
                height: 145.0,
                child: Text(
                  widget.questionContent,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            )
          ],
        ),
        SizedBox(height: 40.0),
        TextFormField(
          maxLines: 15,
          maxLength: maxLength,
          onChanged: (value) {
            setState(() {
              textValue = value;
            });
          },
          controller: _contentController,
          style: TextStyle(fontSize: 13),
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0)),
            label: Icon(Icons.edit),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: '답변 내용을 작성해주세요...',
            hintStyle: TextStyle(fontSize: 13),
          ),
        ),
        SizedBox(height: 60.0),
        AnswerRegisterBottomButton(
          contentController: _contentController,
          qnaNo: widget.qnaNo,
          answerContent: textValue,
        ),
      ],
    );
  }
}
