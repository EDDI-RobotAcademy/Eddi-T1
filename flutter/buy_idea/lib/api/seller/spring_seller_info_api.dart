import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../component/seller/my_info/seller_info_data.dart';

class SpringSellerInfoApi {
  static const String httpUri = '192.168.0.8:8888';
  static var sellerInfoResponse;
  static var sellerInfoRegisterResponse;

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

  sellerProfileRegister(SellerProfileRequest request) async {
    Map addressInfoMap = {
      'zipcode' : request.companyInfoRequest.zipcode,
      'city' : request.companyInfoRequest.city,
      'street' : request.companyInfoRequest.street,
      'addressDetail' : request.companyInfoRequest.addressDetail,
    };

    var data = {
      'nickname': request.nickname,
      'realName': request.realName,
      'phone': request.phone,
      'registrationNumber': request.registrationNumber,
      'companyInfoRequest': addressInfoMap
    };

    var body = json.encode(data);

    sellerInfoRegisterResponse = await http.post(
      Uri.http(httpUri, '/seller/profile/register'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
  }
}

class SellerProfileRequest {
  String nickname;
  String realName;
  String phone;
  String registrationNumber;
  CompanyInfoRequest companyInfoRequest;

  SellerProfileRequest(this.nickname, this.realName, this.phone,
      this.registrationNumber, this.companyInfoRequest);

  Map<String, dynamic> toJson() =>
      {
        'nickname': nickname,
        'realName': realName,
        'phone': phone,
        'registrationNumber': registrationNumber,
        'companyInfoRequest': companyInfoRequest,
      };
}

class CompanyInfoRequest {
  String zipcode;
  String city;
  String street;
  String addressDetail;

  CompanyInfoRequest(this.city, this.street, this.addressDetail, this.zipcode);
}
