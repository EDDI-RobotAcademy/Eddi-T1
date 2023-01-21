import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../component/buyer/shopping_bucket/shopping_bucket_product.dart';
import 'ip_info.dart';

class SpringShoppingBucketApi {
  static var bucketRegisterResponse;
  static var bucketDeleteResponse;

  Future<List<ShoppingBucketProduct>> shoppingBucketList(
      String memberNickname) async {
    debugPrint('memberNickname : ' + memberNickname);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/order/shopping-bucket-list/$memberNickname'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<ShoppingBucketProduct> bucketList =
          data.map((list) => ShoppingBucketProduct.fromJson(list)).toList();

      debugPrint(bucketList.toString());

      return bucketList;
    } else {
      throw Exception('productDetailsInfo() 에러 발생');
    }
  }

  shoppingBucketRegister(ShoppingBucketRequest shoppingBucketRequest) async {
    var body = json.encode(shoppingBucketRequest);

    bucketRegisterResponse = await http.post(
      Uri.http(IpInfo.httpUri, '/order/register/shopping-bucket'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
  }

  shoppingBucketDelete(int itemId, String nickname) async {

    bucketDeleteResponse = await http.delete(
      Uri.http(IpInfo.httpUri, '/order/shopping-bucket-list/delete',
          {'itemId': itemId.toString(), 'nickname': nickname.toString()}),
      headers: {"Content-Type": "application/json"},
    );

  }
}

class ShoppingBucketRequest {
  int productId;
  String nickname;
  int productAmountValue;

  ShoppingBucketRequest(this.productId, this.nickname, this.productAmountValue);

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'nickname': nickname,
        'productAmountValue': productAmountValue,
      };
}
