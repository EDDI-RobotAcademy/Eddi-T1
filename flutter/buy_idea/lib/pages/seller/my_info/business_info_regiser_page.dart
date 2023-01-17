import 'package:flutter/material.dart';

import '../../../component/seller/app_bar/seller_common_app_bar.dart';
import '../../../component/seller/app_bar/seller_drawer.dart';
import '../../../component/seller/my_info/business_info_register_form.dart';
import '../seller_main_page.dart';

class BusinessInfoRegisterPage extends StatefulWidget {
  const BusinessInfoRegisterPage({Key? key}) : super(key: key);

  @override
  State<BusinessInfoRegisterPage> createState() => _BusinessInfoRegisterPageState();
}

class _BusinessInfoRegisterPageState extends State<BusinessInfoRegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SellerDrawer(nickname: SellerMainPage.sellerNickname),
      appBar: SellerCommonAppBar(
        title: Text('사업자 정보 등록', style: TextStyle(color: Colors.black, fontSize: 15)),
      ),
      body: SingleChildScrollView(child: BusinessInfoRegisterForm()),
    );
  }
}
