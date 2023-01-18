import 'package:buy_idea/pages/seller/seller_main_page.dart';
import 'package:flutter/material.dart';

import '../../../api/seller/spring_seller_order_api.dart';

class OrderStatusCountWidget extends StatefulWidget {
  const OrderStatusCountWidget({Key? key, required}) : super(key: key);

  @override
  State<OrderStatusCountWidget> createState() => _OrderStatusCountWidgetState();
}

class _OrderStatusCountWidgetState extends State<OrderStatusCountWidget> {
  bool loading = false;
  List<int> orderStatusCountList = [];

  @override
  void initState() {
    getSellerOrderInfoListCount();
    super.initState();
  }

  getSellerOrderInfoListCount() async {
    OrderStatusCount list = await SpringSellerOrderApi()
        .getAllOrderStatusCountList(SellerMainPage.sellerNickname);
    orderStatusCountList.add(list.paymentComplete);
    orderStatusCountList.add(list.delivering);
    orderStatusCountList.add(list.delivered);
    orderStatusCountList.add(list.cancel);
    orderStatusCountList.add(list.exchange);
    orderStatusCountList.add(list.refund);

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
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Row(
              children: [
                Text('📋 ', style: TextStyle(fontSize: 28)),
                Text('실시간 주문 현황',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: 360.0,
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF2F4F4F), width: 1),
                borderRadius: BorderRadius.circular(15),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset(
                                "assets/order_status/PAYMENT_COMPLETE.png",
                                width: 80,
                                height: 80),
                            SizedBox(
                                width: 60.0,
                                child: Text('결제 완료',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black))),
                            SizedBox(height: 4.0),
                            SizedBox(
                              width: 40.0,
                              child: Text('${orderStatusCountList[0]}건',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2F4F4F))),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset("assets/order_status/DELIVERING.png",
                                width: 80, height: 80),
                            SizedBox(
                                width: 60.0,
                                child: Text('배송중',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black))),
                            SizedBox(height: 4.0),
                            SizedBox(
                              width: 40.0,
                              child: Text('${orderStatusCountList[1]}건',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2F4F4F))),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset("assets/order_status/DELIVERED.png",
                                width: 80, height: 80),
                            SizedBox(
                                width: 60.0,
                                child: Text('배송 완료',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black))),
                            SizedBox(height: 4.0),
                            SizedBox(
                              width: 40.0,
                              child: Text('${orderStatusCountList[2]}건',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2F4F4F))),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset("assets/order_status/CANCEL.png",
                                width: 80, height: 80),
                            SizedBox(
                                width: 60.0,
                                child: Text('취소',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black))),
                            SizedBox(height: 4.0),
                            SizedBox(
                              width: 40.0,
                              child: Text('${orderStatusCountList[3]}건',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2F4F4F))),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset("assets/order_status/EXCHANGE.png",
                                width: 80, height: 80),
                            SizedBox(
                                width: 60.0,
                                child: Text('교환',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black))),
                            SizedBox(height: 4.0),
                            SizedBox(
                              width: 40.0,
                              child: Text('${orderStatusCountList[4]}건',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2F4F4F))),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Image.asset("assets/order_status/REFUND.png",
                                width: 80, height: 80),
                            SizedBox(
                                width: 60.0,
                                child: Text('환불',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.black))),
                            SizedBox(height: 4.0),
                            SizedBox(
                              width: 40.0,
                              child: Text('${orderStatusCountList[5]}건',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2F4F4F))),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }
  }
}
