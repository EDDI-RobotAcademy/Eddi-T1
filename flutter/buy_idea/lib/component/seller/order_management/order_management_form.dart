import 'package:buy_idea/component/seller/order_management/product_order_status_data.dart';
import 'package:flutter/material.dart';

import '../../../api/seller/spring_seller_order_api.dart';
import '../../../pages/seller/seller_main_page.dart';
import 'order_status_count_widget.dart';
import 'order_status_list.dart';

class OrderManagementForm extends StatefulWidget {
  const OrderManagementForm({Key? key}) : super(key: key);

  @override
  State<OrderManagementForm> createState() => _OrderManagementFormState();
}

class _OrderManagementFormState extends State<OrderManagementForm> {
  List<ProductOrderStatusData> productOrderStatusList = [];
  bool loading = false;

  @override
  void initState() {
    _getSpringSellerOrderStatus();
    super.initState();
  }

  _getSpringSellerOrderStatus() async {
    List<ProductOrderStatusData> list = await SpringSellerOrderApi()
        .getProductOrderStatusList(SellerMainPage.sellerNickname);

    for (var i = 0; i < list.length; i++) {
      productOrderStatusList.add(ProductOrderStatusData(
        category: list[i].category,
        productTitle: list[i].productTitle,
        productImage: list[i].productImage,
        paymentCompleteCount: list[i].paymentCompleteCount,
        deliveringCount: list[i].deliveringCount,
        deliveredCount: list[i].deliveredCount,
        cancelCount: list[i].cancelCount,
        exchangeCount: list[i].exchangeCount,
        refundCount: list[i].refundCount,
      ));
    }

    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Container(
        height: 620.0,
        child: Center(
          child: CircularProgressIndicator(color: Color(0XFF2F4F4F)),
        ),
      );
    } else {
      if (productOrderStatusList.isEmpty) {
        return Container(
            height: 620.0,
            child: const Center(child: Text("등록하신 상품에 대한 주문 내역이 없습니다.")));
      } else {
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
              OrderStatusList(
                productOrderStatusList: productOrderStatusList,
              ),
            ],
          ),
        );
      }
    }
  }
}
