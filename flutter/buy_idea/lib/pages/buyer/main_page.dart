import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../component/buyer/app_bar/bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static dynamic memberId = '';
  static dynamic memberNickname = '';
  static dynamic memberType = '';
  static dynamic userToken = '';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const storage = FlutterSecureStorage();
  bool loading = false;

  @override
  void initState() {
    getMemberInfo();
    super.initState();
  }

  getMemberInfo() async {
    var getId = await storage.read(key: 'memberId');
    var getNickname = await storage.read(key: 'nickname');
    var getMemberType = await storage.read(key: 'memberType');
    var getUserToken = await storage.read(key: 'userToken');

    debugPrint("getId : " + getId.toString());
    debugPrint("getNickname : " + getNickname.toString());
    debugPrint("getMemberType : " + getMemberType.toString());
    debugPrint("getUserToken : " + getUserToken.toString());

    if(getNickname == null){
      setState(() {
        getNickname= '방문객';
        getMemberType = '비회원';
      });
    }

    setState(() {
      MainPage.memberId = getId;
      MainPage.memberNickname = getNickname;
      MainPage.memberType = getMemberType;
      MainPage.userToken = getUserToken;
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Image(
            image: AssetImage('assets/buydia_animation_logo.gif'),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: BottomBar(),
        ),
      );
    }
  }
}
