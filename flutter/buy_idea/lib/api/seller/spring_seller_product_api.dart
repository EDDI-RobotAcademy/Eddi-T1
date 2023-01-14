import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SpringSellerProductApi {
  static const String httpUri = '192.168.0.12:8888';
  static var SearchProductResponse;

  Future<List<RequestSellerProduct>> sellerProductList(String seller, String category, int listSize) async {

    var response = await http.get(
        Uri.http(httpUri, 'product/seller/list', {'seller' : seller, 'category' : category, 'listSize' : listSize.toString()}),
        headers: {'Content-Type' : 'application/json'}
    );

    if (response.statusCode == 200) {
      debugPrint("sellerProductList() 통신 확인");
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<RequestSellerProduct> sellerProductList = data.map((list) => RequestSellerProduct.fromJson(list)).toList();

      return sellerProductList;
    } else {
      throw Exception("sellerProductList() 에러 확인");
    }
  }

  Future<List<RequestSellerProduct>> sellerNextProductList(String seller, String category, int productNo, int listSize) async {

    var response = await http.get(
        Uri.http(httpUri, 'product/seller/list', {'seller' : seller, 'category' : category, 'productNo' : productNo.toString(), 'listSize' : listSize.toString()}),
        headers: {'Content-Type' : 'application/json'}
    );

    if (response.statusCode == 200) {
      debugPrint("sellerNextProductList() 통신 확인");
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<RequestSellerProduct> sellerProductList = data.map((list) => RequestSellerProduct.fromJson(list)).toList();

      return sellerProductList;
    } else {
      throw Exception("sellerNextProductList() 에러 확인");
    }
  }
}

class RequestSellerProduct {
  int productNo;
  String title;
  String seller;
  int price;
  int deliveryFee;
  int stock;
  String regDate;
  String updDate;
  String productImage;
  double starRatingAverage;
  int reviewCount;

  RequestSellerProduct({
    required this.productNo,
    required this.title,
    required this.seller,
    required this.price,
    required this.deliveryFee,
    required this.stock,
    required this.regDate,
    required this.updDate,
    required this.productImage,
    required this.starRatingAverage,
    required this.reviewCount
  });

  factory RequestSellerProduct.fromJson(Map<String, dynamic> json) {
    return RequestSellerProduct(
        productNo: json['productNo'],
        title: json['title'],
        seller: json['seller'],
        price: json['price'],
        deliveryFee: json['deliveryFee'],
        stock: json['stock'],
        regDate: json['regDate'],
        updDate: json['updDate'],
        productImage: json['productImage'],
        starRatingAverage: json['starRatingAverage'],
        reviewCount: json['reviewCount']
    );
  }
}