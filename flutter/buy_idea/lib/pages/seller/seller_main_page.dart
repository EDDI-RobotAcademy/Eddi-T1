import 'package:buy_idea/api/seller/spring_seller_total_api.dart';
import 'package:buy_idea/component/seller/app_bar/seller_common_app_bar.dart';
import 'package:buy_idea/component/seller/home/total_sales_form.dart';
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
    await getTotal(SellerMainPage.sellerNickname);
  }

  bool totalLoading = false;

  int sales = 0;

  getTotal(String seller) async {
    sales = await SpringSellerTotalApi().requestTotalSales(seller);
    setState(() {
      sales;
      totalLoading = true;
    });
  }

  @override
  void initState() {
    getSellerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(loading == true && totalLoading == true){
      return Scaffold(
          drawer: SellerDrawer(nickname: SellerMainPage.sellerNickname),
          appBar: SellerCommonAppBar(
            title: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerMainPage()));
              },
              child: Image.asset('assets/buydia_logo.png', width: 100),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TotalSalesForm(sales: sales),
                SizedBox(height: 10)
              ],
            ),
          )
      );
    } else {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Image(
            image: AssetImage('assets/buydia_animation_logo.gif'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
