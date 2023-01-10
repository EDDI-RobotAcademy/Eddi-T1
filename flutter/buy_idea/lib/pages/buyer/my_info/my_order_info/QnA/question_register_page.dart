import 'package:buy_idea/component/buyer/my_info/my_order_info/QnA/question_register_form.dart';
import 'package:flutter/material.dart';

import '../../../../../component/buyer/app_bar/title_top_bar.dart';

class QuestionRegisterPage extends StatefulWidget {
  const QuestionRegisterPage(
      {Key? key,
      required this.productNo,
      required this.productImage,
      required this.productTitle,
      required this.nickname})
      : super(key: key);
  final int productNo;
  final String productImage;
  final String nickname;
  final String productTitle;

  @override
  State<QuestionRegisterPage> createState() => _QuestionRegisterPageState();
}

class _QuestionRegisterPageState extends State<QuestionRegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TitleTopBar(titleText: '문의하기'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(children: [
                  Text(widget.nickname,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2F4F4F))),
                  Text('에게 문의',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ]),
                Row(
                  children: [
                    Text('답변은 내 정보 > 문의 내역 또는 상품 상세정보 > 문의에서 ',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                Row(
                  children: [
                    Text('확인할 수 있습니다. ',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    InkWell(
                      onTap: (){
                        ///문의 내역 페이지 연결
                      },
                      child: Text('문의내역 바로가기 >',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2F4F4F))),
                    ),
                  ],
                ),
                SizedBox(height: 30.0),
                QuestionRegisterForm(
                  productNo: widget.productNo,
                  productImage: widget.productImage,
                  productTitle: widget.productTitle,
                ),
              ],
            ),
          ),
        ));
  }
}
