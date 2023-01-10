import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/yes_or_no_alert_dialog.dart';

class MyQuestionHistoryCard extends StatefulWidget {
  const MyQuestionHistoryCard({Key? key}) : super(key: key);

  @override
  State<MyQuestionHistoryCard> createState() => _MyQuestionHistoryCardState();
}

class _MyQuestionHistoryCardState extends State<MyQuestionHistoryCard> {
  @override
  Widget build(BuildContext context) {
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
                  Icon(Icons.lock, color: Colors.grey, size: 20),
                  // Icon(Icons.lock_open, color: Colors.grey, size: 20),
                  SizedBox(width: 4.0),

                  /// 답변 상태 따라 텍스트 띄우기
                  // Text('답변 대기 | ', style: TextStyle(color: Colors.grey),),
                  Text('답변 완료 | ',
                      style: TextStyle(
                          color: Color(0xFFDAA520),
                          fontWeight: FontWeight.bold)),
                  Text('배송 문의'),
                  Expanded(child: SizedBox()),
                  Text('닉네임 | ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text('2023-01-11', style: TextStyle(color: Colors.grey , fontSize: 12)),
                  SizedBox(width: 4.0),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return YesOrNoAlertDialog(
                              title: '🗑️',
                              content: '문의 내역을 삭제하시겠습니까?',
                              yesButtonPressed: () {
                                Get.back();

                                /// 삭제 요청
                              },
                              noButtonPressed: () {
                                Get.back();
                              },
                            );
                          });
                    },
                    child: Container(
                      child: Icon(Icons.cancel_outlined),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                children: [
                  Text('[상호명] 상품 타이틀',
                      style: TextStyle(color: Color(0xFF2F4F4F))),
                ],
              ),
              SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Q.',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F4F4F)),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 350.0,
                    child: Text(
                      'Funny how all dreams come true (My dreams come true) '
                      '나를 지켜줄 거야'
                      '아껴왔던 작은 사랑도'
                      ' (You make it feel so good)'
                      'Funny how I feel for you'
                      ' 너의 곁에 그려질'
                      '  꿈결같은 나의 미래도'
                      ' (You gotta be mine 지금도 미래도)'
                      'Dreams come true',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),

              /// 답변 상태에 따라 띄우기
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'A.',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFDAA520)),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    width: 350.0,
                    child: Text(
                      ' 잿빛 세상을 등지고 이 도시를 달려봐'
                      ' 내 맘 가는 대로 가로질러 가볼래 날 위해'
                      ' 그곳이 어디든 날개를 펼치고 I\'m flying'
                      ' 저 쏟아지듯 펼쳐진 길 위로'
                      ' 내 모든 걸 던져'
                      ' Run run run higher, fly fly fly higher'
                      ' I, I find myself 다시 빛나는 나를 봐',
                      style: TextStyle(fontSize: 14),
                    ),
                  )
                ],
              ),
              SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('상호명 | ', style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text('2023-01-11', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
