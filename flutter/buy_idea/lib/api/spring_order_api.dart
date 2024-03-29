import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'ip_info.dart';

class SpringOrderApi {
  static var orderRegisterResponse;

  Future<void> orderRegister(
      List<OrderInfo> orderInfoList, AddressInfo addressInfo) async {
    List<Map> orderInfoMapList = [];
    for (OrderInfo orderInfo in orderInfoList) {
      orderInfoMapList.add({
        'productNo': orderInfo.productNo,
        'buyer': orderInfo.buyer,
        'quantity': orderInfo.quantity,
        'orderStatus': orderInfo.orderStatus,
      });
    }
    Map addressInfoMap = {
      'recipient': addressInfo.recipient,
      'phone': addressInfo.phone,
      'zipcode': addressInfo.zipcode,
      'city': addressInfo.city,
      'street': addressInfo.street,
      'addressDetail': addressInfo.addressDetail,
    };
    var data = {
      'orderInfoRequestList': orderInfoMapList,
      'addressRequest': addressInfoMap
    };
    var body = json.encode(data);

    orderRegisterResponse = await http.post(
        Uri.http(IpInfo.httpUri, '/order/register'),
        headers: {"Content-Type": "application/json"},
        body: body);

    if (orderRegisterResponse.statusCode == 200) {
      debugPrint('통신 확인');
    } else {
      throw Exception('orderRegister() 에러 발생');
    }
  }
}

class OrderInfo {
  String buyer;
  int productNo;
  int quantity;
  String orderStatus;

  OrderInfo(this.buyer, this.productNo, this.quantity, this.orderStatus);
}

class AddressInfo {
  String recipient;
  String phone;
  String zipcode;
  String city;
  String street;
  String addressDetail;

  AddressInfo(this.recipient, this.phone, this.zipcode, this.city, this.street,
      this.addressDetail);
}
