import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SpringSellerTotalApi {
  static const String httpUri = '192.168.0.12:8888';

  Future<int> requestTotalSales(String seller) async {
    var response = await http.get(
      Uri.http(httpUri, '/order/seller/sales/$seller')
    );
    if (response.statusCode == 200) {
      debugPrint("totalSales() 통신 확인");
      int sales = int.parse(response.body);
      return sales;
    } else {
      throw Exception("totalSales() 에러 발생");
    }
  }
}