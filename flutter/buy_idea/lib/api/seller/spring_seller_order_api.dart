import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../component/seller/order_management/product_order_status_data.dart';
import '../ip_info.dart';

class SpringSellerOrderApi {

  Future<List<ProductOrderStatusData>> getProductOrderStatusList(String nickname) async {
    debugPrint('getProductOrderStatusList()');

    var response = await http.post(
        Uri.http(IpInfo.httpUri, '/order/seller-order-status/$nickname'),
        headers: {"Content-Type": "application/json"});

    var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    if (response.statusCode == 200) {
      List<ProductOrderStatusData> productOrderStatusList =
          data.map((list) => ProductOrderStatusData.fromJson(list)).toList();

      debugPrint('통신 확인');
      return productOrderStatusList;
    } else {
      throw Exception('getProductOrderStatusList() 에러 발생');
    }
  }

  Future<OrderStatusCount> getAllOrderStatusCountList(String nickname) async {
    debugPrint('getAllOrderStatusList()');

    var response = await http.post(
        Uri.http(IpInfo.httpUri, '/order/seller-order-info-list-count/$nickname'),
        headers: {"Content-Type": "application/json"}
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      OrderStatusCount allOrderStatusCountList = OrderStatusCount.fromJson(data);

      debugPrint('통신 확인');
      return allOrderStatusCountList;
    } else {
      throw Exception('getAllOrderStatusList() 에러 발생');
    }
  }
}

class OrderStatusCount {
  int paymentComplete;
  int delivering;
  int delivered;
  int cancel;
  int exchange;
  int refund;

  OrderStatusCount({
    required this.paymentComplete,
    required this.delivering,
    required this.delivered,
    required this.cancel,
    required this.exchange,
    required this.refund
  });

  factory OrderStatusCount.fromJson(List<dynamic> json) {
    return OrderStatusCount(
        paymentComplete: json[0],
        delivering: json[1],
        delivered: json[2],
        cancel: json[3],
        exchange: json[4],
        refund: json[5]
    );
  }
}
