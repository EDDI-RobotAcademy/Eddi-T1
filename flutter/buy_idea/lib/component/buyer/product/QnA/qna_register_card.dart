import 'package:buy_idea/pages/account/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../pages/buyer/my_info/my_order_info/QnA/question_register_page.dart';
import '../../../common/yes_or_no_alert_dialog.dart';

class QnaRegisterCard extends StatefulWidget {
  const QnaRegisterCard(
      {Key? key,
      required this.nickname,
      required this.productNo,
      required this.image,
      required this.title})
      : super(key: key);
  final String nickname;
  final int productNo;
  final String image;
  final String title;

  @override
  State<QnaRegisterCard> createState() => _QnaRegisterCardState();
}

class _QnaRegisterCardState extends State<QnaRegisterCard> {
  static const _storage = FlutterSecureStorage();
  dynamic memberNickname = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _asyncMethod();
  }

  _asyncMethod() async {
    memberNickname = await _storage.read(key: 'nickname');
    if (memberNickname == null) {
      setState(() {
        memberNickname = '비회원';
      });
    } else {
      setState(() {
        memberNickname = memberNickname;
      });
      debugPrint('닉네임 : $memberNickname');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '상품 문의',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Expanded(child: SizedBox()),
              TextButton(
                  onPressed: () {
                    if (memberNickname == '비회원') {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return YesOrNoAlertDialog(
                              title: '🔐️',
                              content: '로그인한 회원만 이용 가능합니다.\n'
                                  '로그인 페이지로 이동하시겠습니까?',
                              yesButtonPressed: () {
                                Get.to(SignInPage());
                              },
                              noButtonPressed: () {
                                Get.back();
                              },
                            );
                          });
                    } else {
                      /// 문의 등록 페이지
                      Get.to(QuestionRegisterPage(
                        productNo: widget.productNo,
                        productImage: widget.image,
                        productTitle: widget.title,
                        nickname: widget.nickname,
                      ));
                    }
                  },
                  child: SizedBox(
                    width: 80,
                    child: const Text('문의하기',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xFF2F4F4F), fontSize: 12)),
                  ),
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(
                          color: Color(0xFF2F4F4F), width: 1.0),
                      elevation: 0,
                      primary: Colors.white)),
            ],
          ),
          Row(
            children: [
              SizedBox(
                  width: 380,
                  child: Text('• 상품 문의는 로그인한 회원만 작성할 수 있습니다.',
                      style: TextStyle(fontSize: 12))),
            ],
          ),
          Row(
            children: [
              SizedBox(
                  width: 380,
                  child: Text(
                    '• 고객님의 개인정보가 포함된 문의는 반드시 비밀글로 작성해주세요.',
                    style: TextStyle(fontSize: 12),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
