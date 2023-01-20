import 'package:get/get.dart';

class FavoriteController extends GetxController {
  static late var myFavoriteStatus = {};
  static late var myFavoriteList = [];
  static late bool productFavoriteStatus;

  void setFavoriteStatus() {
    productFavoriteStatus = myFavoriteStatus['productFavoriteStatus'];
  }
}
