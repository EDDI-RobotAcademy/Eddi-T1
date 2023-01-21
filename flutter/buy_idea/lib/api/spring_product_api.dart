import 'package:buy_idea/component/buyer/category/category_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'ip_info.dart';

class SpringProductApi {
  static var SearchProductResponse;

  Future<List<RequestProductThumbnailInfo>> firstProductList(
      String category, int productSize, String viewMode) async {

    var body = {
      'category' : category,
      'productSize' : productSize,
      'filter' : viewMode
    };

    var jsonBody = json.encode(body);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/product/list'),
      headers: {"Content-Type": "application/json"},
      body: jsonBody
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<RequestProductThumbnailInfo> productList = data
          .map((list) => RequestProductThumbnailInfo.fromJson(list))
          .toList();

      debugPrint(productList.toString());

      return productList;
    } else {
      throw Exception('firstProductList() 에러 발생');
    }
  }

  Future<List<RequestProductThumbnailInfo>> nextProductList(
      int productNo, String category, int productSize, String viewMode, List<int> productNoList) async {

    var body = {
      'productNo' : productNo,
      'category' : category,
      'productSize' : productSize,
      'filter' : viewMode,
      'productNoList' : productNoList
    };

    var jsonBody = json.encode(body);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/product/list/next'),
      headers: {"Content-Type": "application/json"},
      body: jsonBody
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<RequestProductThumbnailInfo> productList = data
          .map((list) => RequestProductThumbnailInfo.fromJson(list))
          .toList();

      debugPrint(productList.toString());

      return productList;
    } else {
      throw Exception('nextProductList() 에러 발생');
    }
  }

  Future<RequestProductImage> productThumbnailImage(int productNo) async {
    var response = await http.get(
      Uri.http(IpInfo.httpUri, '/product/image/thumbnail/$productNo'),
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

  Future<RequestProduct> productDetailsInfo(int productNo) async {
    var response = await http.get(
      Uri.http(IpInfo.httpUri, '/product/read/$productNo'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');

      var data = jsonDecode(utf8.decode(response.bodyBytes));
      RequestProduct product = RequestProduct.fromJson(data);

      debugPrint(product.productInfoNo.toString());

      debugPrint(product.toString());

      return product;
    } else {
      throw Exception('productDetailsInfo() 에러 발생');
    }
  }

  Future<List<RequestProductImage>> productImageList(int productNo) async {
    var response = await http.get(
      Uri.http(IpInfo.httpUri, '/product/images/$productNo'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      debugPrint('통신 확인');

      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<RequestProductImage> productImages =
          data.map((list) => RequestProductImage.fromJson(list)).toList();

      debugPrint(productImages.toString());

      return productImages;
    } else {
      throw Exception('productThumbnailImage() 에러 발생');
    }
  }

  Future<List<CategoryProduct>> searchProduct(String searchKeyword) async {
    debugPrint('searchKeyword : ' + searchKeyword);

    SearchProductResponse = await http.get(
      Uri.http(IpInfo.httpUri, '/product/search/$searchKeyword'),
      headers: {"Content-Type": "application/json"},
    );

    if (SearchProductResponse.statusCode == 200) {
      debugPrint('통신 확인');
      var data = jsonDecode(utf8.decode(SearchProductResponse.bodyBytes)) as List;

      List<CategoryProduct> searchProductList =
          data.map((list) => CategoryProduct.fromJson(list)).toList();

      debugPrint(searchProductList.toString());

      return searchProductList;
    } else {
      throw Exception('productDetailsInfo() 에러 발생');
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
    return RequestProductImage(
        imageId: json['imageId'], editedName: json['editedName']);
  }
}

class RequestProduct {
  int productNo;
  String title;
  String nickname;
  int price;
  int productInfoNo;
  String category;
  String content;
  String infoNotice;
  int deliveryFee;
  int stock;
  int viewCnt;
  String regDate;
  String updDate;

  RequestProduct(
      {required this.productNo,
      required this.title,
      required this.nickname,
      required this.price,
      required this.productInfoNo,
      required this.category,
      required this.content,
      required this.infoNotice,
      required this.deliveryFee,
      required this.stock,
      required this.viewCnt,
      required this.regDate,
      required this.updDate});

  factory RequestProduct.fromJson(Map<String, dynamic> json) {
    return RequestProduct(
        productNo: json['productNo'],
        title: json['title'],
        nickname: json['nickname'],
        price: json['price'],
        productInfoNo: json['productInfo']['productInfoNo'],
        category: json['productInfo']['category'],
        content: json['productInfo']['content'],
        infoNotice: json['productInfo']['infoNotice'],
        deliveryFee: json['productInfo']['deliveryFee'],
        stock: json['productInfo']['stock'],
        viewCnt: json['productInfo']['viewCnt'],
        regDate: json['productInfo']['regDate'],
        updDate: json['productInfo']['updDate']);
  }
}
