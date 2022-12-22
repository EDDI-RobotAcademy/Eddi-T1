import 'package:buy_idea/utility/size.dart';
import 'package:flutter/material.dart';

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
              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/default_profile_image.png'),
                backgroundColor: Colors.white,
              ),
              const SizedBox(width: medium_gap),
              Column(
                children: const [
                  Text("로그인 정보가 없습니다.",
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
            ],
          ),
          const SizedBox(height: large_gap),
        ],
      );
    } else {
      return Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/default_profile_image.png'),
                backgroundColor: Colors.white,
              ),
              SizedBox(width: medium_gap),
              Column(
                children: [
                  Text(widget.memberNickname,
                      style: TextStyle(fontSize: 15, color: Colors.black)),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }
}
