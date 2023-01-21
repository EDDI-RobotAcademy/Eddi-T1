import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import '../component/buyer/my_info/my_order_info/my_order_info_product.dart';
import 'ip_info.dart';

class SpringMyInfoApi {

  Future<List<MyOrderInfoProduct>> myOrderInfoList(
      String memberNickname) async {
    debugPrint('memberNickname : ' + memberNickname);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/order/my-order-info-list/$memberNickname'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<MyOrderInfoProduct> myOrderInfoList =
          data.map((list) => MyOrderInfoProduct.fromJson(list)).toList();

      debugPrint(myOrderInfoList.toString());

      return myOrderInfoList;
    } else {
      throw Exception('myOrderInfoList() 에러 발생');
    }
  }

  Future<List<Address>> myOrderAddressInfoList(
      String memberNickname) async {
    debugPrint('memberNickname : ' + memberNickname);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/order/my-order-info-list/$memberNickname'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<Address> myOrderAddressInfoList =
      data.map((list) => Address.fromJson(list)).toList();

      debugPrint(myOrderAddressInfoList.toString());

      return myOrderAddressInfoList;
    } else {
      throw Exception('myOrderInfoList() 에러 발생');
    }
  }
}
