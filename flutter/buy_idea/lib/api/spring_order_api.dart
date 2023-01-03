import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpringOrderApi {

  static const String httpUri = '192.168.0.12:8888';

  Future<void> orderRegister(List<OrderInfo> orderInfoList, AddressInfo addressInfo) async {
    List<Map> orderInfoMapList = [];
    for (OrderInfo orderInfo in orderInfoList) {
      orderInfoMapList.add({
        'buyer' : orderInfo.buyer,
        'seller' : orderInfo.seller,
        'title' : orderInfo.title,
        'quantity' : orderInfo.quantity,
        'price' : orderInfo.price,
        'orderStatus' : orderInfo.orderStatus,
      });
    }
    Map addressInfoMap = {
      'recipient' : addressInfo.recipient,
      'phone' : addressInfo.phone,
      'zipcode' : addressInfo.zipcode,
      'city' : addressInfo.city,
      'street' : addressInfo.street,
      'addressDetail' : addressInfo.addressDetail,
    };
    var data = {
      'orderInfoRequestList' : orderInfoMapList,
      'addressRequest' : addressInfoMap
    };
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(httpUri, '/order/register'),
      headers: {"Content-Type": "application/json"},
      body: body
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
    } else {
      throw Exception('orderRegister() 에러 발생');
    }
  }

}

class OrderInfo {
  String buyer;
  String seller;
  String title;
  int quantity;
  int price;
  String orderStatus;

  OrderInfo(
      this.buyer,
      this.seller,
      this.title,
      this.quantity,
      this.price,
      this.orderStatus
      );
}

class AddressInfo {
  String recipient;
  String phone;
  String zipcode;
  String city;
  String street;
  String addressDetail;

  AddressInfo(
      this.recipient,
      this.phone,
      this.zipcode,
      this.city,
      this.street,
      this.addressDetail
      );
}