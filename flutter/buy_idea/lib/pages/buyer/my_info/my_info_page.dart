import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../component/buyer/app_bar/top_bar.dart';
import '../../../component/buyer/my_info/buyer_info_list_tile_form.dart';
import '../../../component/buyer/my_info/buyer_information.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  static const storage = FlutterSecureStorage();
  dynamic memberNickname = '';
  var statusCheck = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    memberNickname = await storage.read(key: 'nickname');
    if (memberNickname == null) {
      setState(() {
        memberNickname = '비회원';
        statusCheck = true;
      });
    } else {
      setState(() {
        memberNickname = memberNickname;
        statusCheck = true;
      });
      debugPrint('닉네임 : $memberNickname');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (statusCheck == false) {
      return const Padding(
        padding: EdgeInsets.all(100),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.grey,
          ),
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: const TopBar(),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey,
            child: Column(
              children: [
                Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(10),
                    child: BuyerInformation(memberNickname: memberNickname)),
                const SizedBox(height: 1.0),
                BuyerInfoListTileForm(memberNickname: memberNickname),
              ],
            ),
          ),
        ),
      );
    }
  }
}
