import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class WaitForAnswerHistoryCard extends StatefulWidget {
  const WaitForAnswerHistoryCard(
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
  State<WaitForAnswerHistoryCard> createState() => _WaitForAnswerHistoryCardState();
}

class _WaitForAnswerHistoryCardState extends State<WaitForAnswerHistoryCard> {

  @override
  Widget build(BuildContext context) {
    DateTime parseRegDate = DateTime.parse(widget.regDate);
    String regDateFormat = DateFormat('yyyy-MM-dd').format(parseRegDate);

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
              Container(
                width: 300.0,
                child: TextButton(
                    onPressed: () {
                      /// 답변 등록 페이지 이동
                    },
                    child: const Text('답변 하기',
                        style: TextStyle(color: Color(0xFF2F4F4F), fontSize: 14)),
                    style: ElevatedButton.styleFrom(
                        side:
                        const BorderSide(color: Color(0xFF2F4F4F), width: 1.0),
                        elevation: 0,
                        primary: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
