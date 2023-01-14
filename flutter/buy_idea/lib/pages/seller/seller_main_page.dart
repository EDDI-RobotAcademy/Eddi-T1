import 'package:buy_idea/component/seller/app_bar/seller_common_app_bar.dart';
import 'package:buy_idea/pages/seller/seller_info.dart';
import 'package:flutter/material.dart';

import '../../component/seller/app_bar/seller_drawer.dart';

class SellerMainPage extends StatefulWidget {
  const SellerMainPage({Key? key}) : super(key: key);

  @override
  State<SellerMainPage> createState() => _SellerMainPageState();
}

class _SellerMainPageState extends State<SellerMainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SellerDrawer(nickname: SellerInfo.sellerNickname),
      appBar: SellerCommonAppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerMainPage()));
          },
          child: Image.asset('assets/buydia_logo.png', width: 100),
        ),
      ),
      body: Container(child: Center(child: Text('Home')),)
    );
  }

}
