import 'package:buy_idea/component/seller/my_info/seller_information.dart';
import 'package:flutter/material.dart';

import '../../../component/seller/app_bar/seller_common_app_bar.dart';
import '../../../component/seller/app_bar/seller_drawer.dart';
import '../seller_main_page.dart';

class SellerMyInfoPage extends StatefulWidget {
  const SellerMyInfoPage({Key? key}) : super(key: key);

  @override
  State<SellerMyInfoPage> createState() => _SellerMyInfoPageState();
}

class _SellerMyInfoPageState extends State<SellerMyInfoPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SellerDrawer(nickname: SellerMainPage.sellerNickname),
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
          ],
        ),
      ),
    );
  }
}
