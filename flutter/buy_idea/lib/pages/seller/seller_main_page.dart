import 'package:buy_idea/component/seller/app_bar/seller_common_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../component/seller/app_bar/seller_drawer.dart';

class SellerMainPage extends StatefulWidget {
  const SellerMainPage({Key? key}) : super(key: key);
  static dynamic sellerId = '';
  static dynamic sellerNickname = '';
  static dynamic memberType = '';
  static dynamic userToken ='';

  @override
  State<SellerMainPage> createState() => _SellerMainPageState();
}

class _SellerMainPageState extends State<SellerMainPage> {
  static const storage = FlutterSecureStorage();

  bool loading = false;

  @override
  void initState() {
    getSellerInfo();
    super.initState();
  }

  getSellerInfo() async{
    var getId = await storage.read(key: 'memberId');
    var getNickname = await storage.read(key: 'nickname');
    var getMemberType = await storage.read(key: 'memberType');
    var getUserToken = await storage.read(key: 'userToken');
    setState(() {
      SellerMainPage.sellerId = getId;
      SellerMainPage.sellerNickname = getNickname;
      SellerMainPage.memberType = getMemberType;
      SellerMainPage.userToken = getUserToken;
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(loading == false){
      return Container(
        color: Colors.white,
        child: const Center(
          child: Image(
            image: AssetImage('assets/buydia_animation_logo.gif'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }else return Scaffold(
      drawer: SellerDrawer(nickname: SellerMainPage.sellerNickname),
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
