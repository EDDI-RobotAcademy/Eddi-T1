import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../component/seller/order_management/product_order_status_data.dart';

class SpringSellerOrderApi {
  static const String httpUri = '192.168.0.8:8888';

  Future<List<ProductOrderStatusData>> getProductOrderStatusList(
      String nickname) async {
    debugPrint('getProductOrderStatusList()');

    var response = await http.post(
        Uri.http(httpUri, '/order/seller-order-status/$nickname'),
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
}
