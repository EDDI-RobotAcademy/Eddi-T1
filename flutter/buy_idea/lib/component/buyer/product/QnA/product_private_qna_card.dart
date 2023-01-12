import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductPrivateQnaCard extends StatefulWidget {
  const ProductPrivateQnaCard(
      {Key? key,
      required this.writer,
      required this.answerStatus,
      required this.regDate,
      required this.openStatus})
      : super(key: key);
  final String writer;
  final String answerStatus;
  final String regDate;
  final bool openStatus;

  @override
  State<ProductPrivateQnaCard> createState() => _ProductPrivateQnaCardState();
}

class _ProductPrivateQnaCardState extends State<ProductPrivateQnaCard> {

  String privateWriter = '';

  @override
  void initState() {
    _writerChangePrivate();
    super.initState();
  }

  _writerChangePrivate() {
    for (var i = 0; i < widget.writer.length; i++) {
      var char = widget.writer[i];
      if(i > 1){
        privateWriter = privateWriter + '*';
      }else{
        privateWriter = privateWriter + char;
      }
    }
    debugPrint('privateWriter : ' + privateWriter);
  }

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
                  Text('$privateWriter | ',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text(regDateFormat,
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              SizedBox(height: 5.0),
              Row(children: [
                Text(
                  '비밀글입니다.',
                  style: TextStyle(color: Colors.black),
                ),
              ]),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
