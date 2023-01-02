import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OrderingCustomerInfoForm extends StatefulWidget {
  const OrderingCustomerInfoForm({Key? key}) : super(key: key);

  @override
  State<OrderingCustomerInfoForm> createState() => _OrderingCustomerInfoFormState();
}

class _OrderingCustomerInfoFormState extends State<OrderingCustomerInfoForm> {

  static const storage = FlutterSecureStorage();
  dynamic nickname = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    nickname = await storage.read(key: 'nickname');
    setState(() {
      nickname = nickname;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주문 고객', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Divider(height: 20, color: Colors.grey, thickness: 1,),
          Row(
            children: [
              Text('닉네임', style: TextStyle(fontSize: 13, color: Colors.grey)),
              SizedBox(width: 35),
              Text(nickname, style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
