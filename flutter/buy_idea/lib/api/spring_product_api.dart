import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SpringProductApi {

  static const String httpUri = '192.168.0.12:8888';

  Future<List<RequestProductThumbnailInfo>> firstProductList(String category, int productSize) async {

    var response = await http.get(
      Uri.http(httpUri, '/product/list', {'category' : category, 'productSize' : productSize.toString()}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<RequestProductThumbnailInfo> productList = data.map((list) =>
          RequestProductThumbnailInfo.fromJson(list)).toList();

      debugPrint(productList.toString());

      return productList;
    } else {
      throw Exception('firstProductList() 에러 발생');
    }
  }

  Future<List<RequestProductThumbnailInfo>> nextProductList(int productNo, String category, int productSize) async {

    var response = await http.get(
      Uri.http(httpUri, '/product/list/next', {'productNo' : productNo.toString(), 'category' : category, 'productSize' : productSize.toString()}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<RequestProductThumbnailInfo> productList = data.map((list) =>
          RequestProductThumbnailInfo.fromJson(list)).toList();

      debugPrint(productList.toString());

      return productList;
    } else {
      throw Exception('nextProductList() 에러 발생');
    }
  }

  Future<RequestProductImage> productThumbnailImage(int productNo) async {

    var response = await http.get(
      Uri.http(httpUri, '/product/image/thumbnail/$productNo'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');

      var data = jsonDecode(utf8.decode(response.bodyBytes));
      RequestProductImage productImage = RequestProductImage.fromJson(data);

      debugPrint(productImage.toString());

      return productImage;
    } else {
      throw Exception('productThumbnailImage() 에러 발생');
    }
  }
}

class RequestProductThumbnailInfo {
  int productNo;
  String title;
  String nickname;
  int price;

  RequestProductThumbnailInfo({
    required this.productNo,
    required this.title,
    required this.nickname,
    required this.price,
  });

  factory RequestProductThumbnailInfo.fromJson(Map<String, dynamic> json) {
    return RequestProductThumbnailInfo(
        productNo: json['productNo'],
        title: json['title'],
        nickname: json['nickname'],
        price: json['price'],
    );
  }
}

class RequestProductImage {
  int imageId;
  String editedName;

  RequestProductImage({required this.imageId, required this.editedName});

  factory RequestProductImage.fromJson(Map<String, dynamic> json) {
    return RequestProductImage(imageId: json['imageId'], editedName: json['editedName']);
  }
}