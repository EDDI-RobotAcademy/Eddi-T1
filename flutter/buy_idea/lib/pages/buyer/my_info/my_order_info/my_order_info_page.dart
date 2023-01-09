import 'dart:collection';
import 'package:buy_idea/component/buyer/my_info/my_order_info/my_order_info_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../api/spring_my_info_api.dart';
import '../../../../component/buyer/app_bar/title_top_bar.dart';
import '../../../../component/buyer/my_info/my_order_info/my_order_info_product.dart';

class OrderInfoPage extends StatefulWidget {
  const OrderInfoPage({Key? key}) : super(key: key);

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  static const _storage = FlutterSecureStorage();
  LinkedHashSet<String> orderNoList = LinkedHashSet();
  LinkedHashSet<String> orderDateList = LinkedHashSet();
  bool loading = false;
  int gridViewHeightSize = 760;
  dynamic memberNickname = '';

  @override
  void initState() {
    _getMyOrderInfoList();
    super.initState();
  }

  _getMyOrderInfoList() async {
    setState(() {
      loading = false;
    });
    memberNickname = await _storage.read(key: 'nickname');
    List<MyOrderInfoProduct> orderInfoList =
        await SpringMyInfoApi().myOrderInfoList(memberNickname);

    myOrderInfoList.clear();
    for (var i = 0; i < orderInfoList.length; i++) {
      myOrderInfoList.add(MyOrderInfoProduct(
          title: orderInfoList[i].title,
          image: orderInfoList[i].image,
          nickname: orderInfoList[i].nickname,
          orderStatus: orderInfoList[i].orderStatus,
          productNo: orderInfoList[i].productNo,
          price: orderInfoList[i].price,
          deliveryFee: orderInfoList[i].deliveryFee,
          orderDate: orderInfoList[i].orderDate,
          quantity: orderInfoList[i].quantity,
          orderNo: orderInfoList[i].orderNo));

      orderNoList.add(orderInfoList[i].orderNo);
      orderDateList.add(orderInfoList[i].orderDate);
    }

    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      return const Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: TitleTopBar(titleText: '주문 / 배송'),
          body: Center(
              child: CircularProgressIndicator(color: Color(0XFF2F4F4F))));
    } else {
      if (myOrderInfoList.isEmpty) {
        return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: const TitleTopBar(titleText: '주문 / 배송'),
            body: Container(
                color: Colors.white,
                child: const Center(child: Text("No order info found!"))));
      }
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const TitleTopBar(titleText: '주문 / 배송'),
          body: Container(
            color: Colors.grey,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderNoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MyOrderInfoForm(
                      orderNo: orderNoList.elementAt(index),
                      orderDate: orderDateList.elementAt(index),
                    );
                  }),
            ),
          );
    }
  }
}
