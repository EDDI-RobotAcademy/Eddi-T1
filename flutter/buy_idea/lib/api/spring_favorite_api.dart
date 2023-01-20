import 'dart:convert';

import 'package:buy_idea/pages/buyer/product/favorite_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SpringFavoriteApi {
  static const String httpUri = '192.168.0.8:8888';

  requestFavoriteStatus(FavoriteRequest request) async {
    var data = {
      'productNo': request.productNo,
      'nickname': request.nickname,
      'favoriteReference': request.favoriteReference
    };
    var body = json.encode(data);
    debugPrint('requestFavoriteStatus()');

    var response = await http.post(Uri.http(httpUri, '/favorite/status'),
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
}

class FavoriteRequest {
  int productNo;
  String nickname;
  String favoriteReference;

  FavoriteRequest(this.productNo, this.nickname, this.favoriteReference);
}
