import 'dart:convert';

import 'package:buy_idea/pages/buyer/product/favorite_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../component/buyer/my_info/my_favorite/my_favorite_product.dart';
import 'ip_info.dart';

class SpringFavoriteApi {
  requestFavoriteStatus(FavoriteRequest request) async {
    var data = {
      'productNo': request.productNo,
      'nickname': request.nickname,
      'favoriteReference': request.favoriteReference
    };
    var body = json.encode(data);
    debugPrint('requestFavoriteStatus()');

    var response = await http.post(Uri.http(IpInfo.httpUri, '/favorite/status'),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 200) {
      debugPrint('requestFavoriteStatus : ' +
          utf8.decode(response.bodyBytes).toString());
      FavoriteController.myFavoriteStatus =
          jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('requestFavoriteStatus() 에러 발생');
    }
  }


  Future<List<FavoriteProduct>> requestMyFavoriteProductList(String nickname) async {
    debugPrint('requestMyFavoriteProductList()');
    var body = json.encode(nickname);

    var response = await http.post(
        Uri.http(IpInfo.httpUri, '/favorite/my-list/$nickname'),
        headers: {"Content-Type": "application/json"},
        body: body);

    var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

    if (response.statusCode == 200) {
      List<FavoriteProduct> myFavoriteList =
      data.map((list) => FavoriteProduct.fromJson(list)).toList();

      debugPrint('통신 확인');
      return myFavoriteList;
    } else {
      throw Exception('requestMyFavoriteProductList() 에러 발생');
    }
  }
}

class FavoriteRequest {
  int productNo;
  String nickname;
  String favoriteReference;

  FavoriteRequest(this.productNo, this.nickname, this.favoriteReference);
}
