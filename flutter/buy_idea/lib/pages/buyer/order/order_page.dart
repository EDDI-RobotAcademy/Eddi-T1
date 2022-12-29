import 'package:buy_idea/component/buyer/app_bar/title_top_bar.dart';
import 'package:buy_idea/component/buyer/order/ordering_customer_info_form.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleTopBar(titleText: '상품 결제'),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: Column(
            children: [
              OrderingCustomerInfoForm(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
