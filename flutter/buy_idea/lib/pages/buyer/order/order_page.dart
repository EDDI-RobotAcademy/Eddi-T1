import 'package:buy_idea/component/buyer/app_bar/title_top_bar.dart';
import 'package:buy_idea/component/buyer/order/delivery_address_input_form.dart';
import 'package:buy_idea/component/buyer/order/ordering_customer_info_form.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController addressDetailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TitleTopBar(titleText: '상품 결제'),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey,
            child: Column(
              children: [
                OrderingCustomerInfoForm(),
                SizedBox(height: 10),
                DeliveryAddressInputForm(
                  recipientController: recipientController,
                  phoneController: phoneController,
                  zipcodeController: zipcodeController,
                  cityController: cityController,
                  streetController: streetController,
                  addressDetailController: addressDetailController,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
