import 'package:buy_idea/component/seller/my_info/seller_information.dart';
import 'package:buy_idea/pages/account/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../component/seller/app_bar/seller_common_app_bar.dart';
import '../../../component/seller/app_bar/seller_drawer.dart';
import '../seller_info.dart';

class SellerMyInfoPage extends StatefulWidget {
  const SellerMyInfoPage({Key? key}) : super(key: key);

  @override
  State<SellerMyInfoPage> createState() => _SellerMyInfoPageState();
}

class _SellerMyInfoPageState extends State<SellerMyInfoPage> {
  static const storage = FlutterSecureStorage();

  _logout() async {
    await storage.delete(key: 'userToken');
    await storage.delete(key: 'memberId');
    await storage.delete(key: 'nickname');
    await storage.delete(key: 'memberType');
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SellerDrawer(nickname: SellerInfo.sellerNickname),
      appBar: SellerCommonAppBar(
        title: Text('내 정보', style: TextStyle(color: Colors.black, fontSize: 15)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.grey,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: SellerInformation()
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
}
