import 'package:buy_idea/utility/size.dart';
import 'package:flutter/material.dart';

import 'buyer_info_card.dart';

class BuyerInformation extends StatefulWidget {
  const BuyerInformation({Key? key, required this.memberNickname})
      : super(key: key);

  @override
  State<BuyerInformation> createState() => _BuyerInformationState();
  final String memberNickname;
}

class _BuyerInformationState extends State<BuyerInformation> {
  @override
  Widget build(BuildContext context) {
    if (widget.memberNickname == '비회원') {
      return Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/default_profile_image.png'),
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: medium_gap),
              Column(
                children: const [
                  Text("로그인 정보가 없습니다.",
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Color(0xFF2F4F4F),
                ),
              )
            ],
          )
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('assets/default_profile_image.png'),
                  backgroundColor: Colors.white,
                ),
              ),
              SizedBox(width: medium_gap),
              Column(
                children: [
                  Text(widget.memberNickname,
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                ],
              ),
            ],
          ),
          SizedBox(height: large_gap),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              BuyerInfoCard(
                iconData: Icons.card_giftcard_outlined,
                menuTitle: '주문 배송',
              ),
              BuyerInfoCard(
                iconData: Icons.lightbulb_outlined,
                menuTitle: '찜한 아이디어',
              ),
              BuyerInfoCard(
                iconData: Icons.question_answer_outlined,
                menuTitle: '문의 내역',
              ),
              BuyerInfoCard(
                iconData: Icons.note_alt_outlined,
                menuTitle: '나의 후기',
              ),
            ],
          ),
        ],
      );
    }
  }
}
