import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../component/buyer/app_bar/top_bar.dart';
import '../../../component/buyer/my_info/buyer_information.dart';
import '../../../component/common/common_alert_dialog.dart';
import '../../account/sign_in_page.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {

  static const storage = FlutterSecureStorage();

  _logout() async {
    await storage.delete(key: 'userToken');
    await storage.delete(key: 'memberId');
    await storage.delete(key: 'nickname');
    await storage.delete(key: 'memberType');
    _signOutSuccessShowDialog();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey,
        child: Column(
          children: [
            Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: BuyerInformation()
            ),
            SizedBox(height: 20),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: _logout,
                title: Text('로그아웃', style: TextStyle(color: Color(0xffDAA520), fontWeight: FontWeight.bold)),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 로그아웃 성공 alertDialog
  void _signOutSuccessShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
              title: '👋️',
              content: '안전하게 로그아웃 되었습니다.',
              onCustomButtonPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()));
              });
        });
  }
}
