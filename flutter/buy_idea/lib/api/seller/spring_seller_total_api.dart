import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../ip_info.dart';

class SpringSellerTotalApi {

  Future<TotalInfo> requestTotalInfoOfSeller(String seller) async {
    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/seller/total-info/$seller')
    );
    if (response.statusCode == 200) {
      debugPrint("requestTotalInfoOfSeller() 통신 확인");
      var data = jsonDecode(response.body);
      TotalInfo totalInfo = TotalInfo.fromJson(data);
      return totalInfo;
    } else {
      throw Exception("requestTotalInfoOfSeller() 에러 발생");
    }
  }
}

class TotalInfo {
  int totalProduct;
  int totalReview;
  int totalQnA;
  int totalOrder;
  int totalSales;

  TotalInfo({
    required this.totalProduct,
    required this.totalReview,
    required this.totalQnA,
    required this.totalOrder,
    required this.totalSales
  });

  factory TotalInfo.fromJson(Map<String, dynamic> json) {
    return TotalInfo(
        totalProduct: json['totalProduct'],
        totalReview: json['totalReview'],
        totalQnA: json['totalQnA'],
        totalOrder: json['totalOrder'],
        totalSales: json['totalSales']
    );
  }
}