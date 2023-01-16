import 'package:flutter/material.dart';

import 'order_status_count_widget.dart';
import 'order_status_list.dart';

class OrderManagementForm extends StatefulWidget {
  const OrderManagementForm({Key? key}) : super(key: key);

  @override
  State<OrderManagementForm> createState() => _OrderManagementFormState();
}

class _OrderManagementFormState extends State<OrderManagementForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          OrderStatusCountWidget(),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                Text('🔍 ', style: TextStyle(fontSize: 28)),
                Text('상품별 주문 현황',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
          ),
          OrderStatusList(),
        ],
      ),
    );
  }
}
