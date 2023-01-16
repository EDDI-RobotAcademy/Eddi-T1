import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../component/seller/my_info/seller_info_data.dart';

class SpringSellerInfoApi {
  static const String httpUri = '192.168.0.8:8888';
  static var sellerInfoResponse;

  Future<SellerInfoData> getSellerInfo(String nickname) async {
    debugPrint('getSellerInfo()');

    sellerInfoResponse = await http.post(
        Uri.http(httpUri, '/seller/Info/$nickname'),
        headers: {"Content-Type": "application/json"});

    var data = jsonDecode(utf8.decode(sellerInfoResponse.bodyBytes));

    if (sellerInfoResponse.statusCode == 200) {
      SellerInfoData sellerInfoData = SellerInfoData.fromJson(data);

      debugPrint('통신 확인');
      return sellerInfoData;
    } else {
      debugPrint('getSellerInfo() 에러 발생');
      return SellerInfoData(
          realName: '',
          phone: '',
          registrationNumber: '',
          city: '',
          street: '',
          addressDetail: '',
          zipcode: '');
    }
  }
}
