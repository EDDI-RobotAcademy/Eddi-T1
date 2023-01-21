import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../api/spring_my_info_api.dart';
import '../../../../component/buyer/app_bar/title_top_bar.dart';
import '../../../../component/buyer/my_info/my_order_info/my_order_detail_info_form.dart';
import '../../../../component/buyer/my_info/my_order_info/my_order_info_product.dart';

class OrderDetailInfoPage extends StatefulWidget {
  const OrderDetailInfoPage(
      {Key? key,
      required this.myOrderDetailList,
      required this.orderNo,
      required this.orderDate})
      : super(key: key);

  final List<MyOrderInfoProduct> myOrderDetailList;
  final String orderNo;
  final String orderDate;

  @override
  State<OrderDetailInfoPage> createState() => _OrderDetailInfoPageState();
}

class _OrderDetailInfoPageState extends State<OrderDetailInfoPage> {
  static const _storage = FlutterSecureStorage();
  dynamic memberNickname = '';
  bool loading = false;

  @override
  void initState() {
    _getMyOrderAddressList();
    super.initState();
  }

  _getMyOrderAddressList() async {
    memberNickname = await _storage.read(key: 'nickname');
    List<DeliveryAddress> orderAddressList =
        await SpringMyInfoApi().myOrderAddressInfoList(memberNickname);

    myOrderInfoList.clear();
    for (var i = 0; i < orderAddressList.length; i++) {
      myOrderAddressList.add(DeliveryAddress(
          orderNo: orderAddressList[i].orderNo,
          recipient: orderAddressList[i].recipient,
          phone: orderAddressList[i].phone,
          zipcode: orderAddressList[i].zipcode,
          city: orderAddressList[i].city,
          street: orderAddressList[i].street,
          addressDetail: orderAddressList[i].addressDetail));
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
          appBar: TitleTopBar(titleText: '주문 상세정보'),
          body: Center(
              child: CircularProgressIndicator(color: Color(0XFF2F4F4F))));
    } else {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const TitleTopBar(titleText: '주문 상세정보'),
          body: SingleChildScrollView(
            child: MyOrderDetailInfoForm(
              myOrderSliceList: widget.myOrderDetailList,
              orderNo: widget.orderNo,
              orderDate: widget.orderDate,
              memberNickname: memberNickname,
            ),
          ));
    }
  }
}
