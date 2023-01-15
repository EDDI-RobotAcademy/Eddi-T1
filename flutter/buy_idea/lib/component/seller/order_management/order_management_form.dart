import 'package:flutter/material.dart';

import 'order_status_count_widget.dart';

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
        ],
      ),
    );
  }
}
