import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BuyerInformation extends StatefulWidget {
  const BuyerInformation({Key? key}) : super(key: key);

  @override
  State<BuyerInformation> createState() => _BuyerInformationState();
}

class _BuyerInformationState extends State<BuyerInformation> {

  static const storage = FlutterSecureStorage();
  dynamic memberNickname = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    memberNickname = await storage.read(key: 'nickname');
    setState(() {
      memberNickname = memberNickname;
    });
    debugPrint('닉네임 : $memberNickname');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/default_profile_image.png'),
          backgroundColor: Colors.white,
        ),
        SizedBox(width: 10),
        Column(
          children: [
            Text(
                memberNickname
                , style: TextStyle(fontSize: 15, color: Colors.black))
          ],
        ),
      ],
    );
  }
}
