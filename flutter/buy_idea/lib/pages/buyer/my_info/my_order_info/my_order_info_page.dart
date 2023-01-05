import 'package:buy_idea/component/buyer/my_info/my_order_info/my_order_info_form.dart';
import 'package:flutter/material.dart';

import '../../../../component/buyer/app_bar/title_top_bar.dart';

class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage({Key? key}) : super(key: key);

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: TitleTopBar(titleText: '주문 / 배송'),
      body: SingleChildScrollView(
       child:  Container(
         width: MediaQuery.of(context).size.width,
         height: MediaQuery.of(context).size.height,
         color: Colors.grey,
         child: Column(
           children: [
             MyOrderInfoForm(),
             const SizedBox(height: 1.0),
           ],
         ),
       ),
      )
    );
  }
}
