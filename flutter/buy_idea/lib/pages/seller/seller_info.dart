import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SellerInfo {
  static const storage = FlutterSecureStorage();
  static var sellerNickname;

  getSellerInfo()async{
    var getNickname = await storage.read(key: 'nickname');
    sellerNickname = getNickname;
  }
}