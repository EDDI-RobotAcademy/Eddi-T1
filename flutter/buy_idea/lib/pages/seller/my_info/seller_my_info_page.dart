import 'package:buy_idea/component/seller/my_info/seller_profile.dart';
import 'package:flutter/material.dart';

import '../../../component/seller/app_bar/seller_common_app_bar.dart';
import '../../../component/seller/app_bar/seller_drawer.dart';
import '../../../component/seller/my_info/seller_business_info_card.dart';
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
      resizeToAvoidBottomInset: false,
      drawer: SellerDrawer(nickname: SellerMainPage.sellerNickname),
      appBar: SellerCommonAppBar(
        title: Text('내 정보', style: TextStyle(color: Colors.black, fontSize: 15)),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.grey,
          child: Column(
            children: [
              SizedBox(height: 1.0),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(10),
                child: SellerProfile()
              ),
              SizedBox(height: 1.0),
              SellerBusinessInfoCard(),
            ],
          ),
        ),
      ),
    );
  }
}
