import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../component/buyer/shopping_bucket/shopping_bucket_product.dart';

class SpringShoppingBucketApi {
  static const String httpUri = '192.168.0.8:8888';

  Future<List<ShoppingBucketProduct>> shoppingBucketList(
      String memberNickname) async {
    debugPrint('memberNickname : ' + memberNickname);

    var response = await http.post(
      Uri.http(httpUri, '/order/shopping-bucket-list/$memberNickname'),
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
}
