import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/title_top_bar.dart';
import '../../../component/seller/app_bar/seller_drawer.dart';
import '../../../component/seller/order_management/order_management_form.dart';
import '../seller_main_page.dart';

class OrderManagementPage extends StatefulWidget {
  const OrderManagementPage({Key? key}) : super(key: key);

  @override
  State<OrderManagementPage> createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SellerDrawer(nickname: SellerMainPage.sellerNickname),
      appBar: TitleTopBar(titleText: '주문 관리'),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OrderManagementForm(),
      ),
    );
  }
}
