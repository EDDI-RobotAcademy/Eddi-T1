import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../pages/account/sign_in_page.dart';
import '../../common/common_alert_dialog.dart';

class BuyerInfoListTileWidget extends StatefulWidget {
  const BuyerInfoListTileWidget({Key? key, required this.memberNickname})
      : super(key: key);

  @override
  State<BuyerInfoListTileWidget> createState() =>
      _BuyerInfoListTileWidgetState();
  final String memberNickname;
}

class _BuyerInfoListTileWidgetState extends State<BuyerInfoListTileWidget> {
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
    if (widget.memberNickname == '비회원') {
      return Container(
        color: Colors.white,
        child: ListTile(
          onTap: () {
            Get.to(const SignInPage());
          },
          title: const Text('로그인 페이지로 이동',
              style: TextStyle(
                  color: Color(0xffDAA520), fontWeight: FontWeight.bold)),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        child: ListTile(
          onTap: _logout,
          title: const Text('로그아웃',
              style: TextStyle(
                  color: Color(0xffDAA520), fontWeight: FontWeight.bold)),
        ),
      );
    }
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
                Get.offAll(const MainPage());
              });
        });
  }
}
