import 'package:buy_idea/api/spring_shopping_bucket_api.dart';
import 'package:buy_idea/component/buyer/shopping_bucket/shopping_bucket_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ShoppingController extends GetxController {
  static const _storage = FlutterSecureStorage();
  List<ShoppingBucketProduct> productData = [];
  List<int> productNoList = [];
  List<int> purchaseQuantityList = [];
  List<int> bucketItemIdList = [];
  var bucketProducts = <ShoppingBucketProduct>[].obs;
  dynamic memberNickname;
  var sumDeliveryFee;
  var loading = false.obs;
  RxInt totalPrice = 0.obs;

  void setOrderList(){
    for(var i = 0; i < bucketProducts.length; i++){
      productNoList.add(bucketProducts[i].productNo);
      purchaseQuantityList.add(bucketProducts[i].itemCount);
      bucketItemIdList.add(bucketProducts[i].itemId);
    }
  }

  void deleteItem(ShoppingBucketProduct product, int index) {
    bucketProducts.removeAt(index);
    bucketProducts.refresh();
    checkTotalPrice(bucketProducts);
  }

  void addToItemPrice(ShoppingBucketProduct product, int index) {
    bucketProducts[index].itemCount++;
    checkDeliveryFee(index);
    bucketProducts.refresh();
    checkTotalPrice(bucketProducts);
  }

  void removeToItemPrice(ShoppingBucketProduct product, int index) {
    bucketProducts[index].itemCount--;
    checkDeliveryFee(index);
    bucketProducts.refresh();
    checkTotalPrice(bucketProducts);
  }

  void checkDeliveryFee(int index) {
    if (bucketProducts[index].price * bucketProducts[index].itemCount >=
        50000) {
      bucketProducts[index].sumDeliveryFee = 0;
    } else {
      bucketProducts[index].sumDeliveryFee = bucketProducts[index].deliveryFee;
    }
  }

  void checkTotalPrice(List<ShoppingBucketProduct> bucketProducts) {
    totalPrice.value = 0;
    totalPrice.refresh();
    for (int i = 0; i < bucketProducts.length; i++) {
      totalPrice.value +=
          (bucketProducts[i].price * bucketProducts[i].itemCount) +
              bucketProducts[i].sumDeliveryFee;
    }
    totalPrice.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    _asyncMethod();
  }

  void _asyncMethod() async {
    memberNickname = await _storage.read(key: 'nickname');
    await loadBucketFromApi(memberNickname);
  }

  loadBucketFromApi(String memberNickname) async {
    loading(true);
    List<ShoppingBucketProduct> bucketList =
        await SpringShoppingBucketApi().shoppingBucketList(memberNickname);
    debugPrint('bucketList : $bucketList');

    for (var i = 0; i < bucketList.length; i++) {
      if (bucketList[i].price * bucketList[i].itemCount >= 50000) {
        sumDeliveryFee = 0;
      } else {
        sumDeliveryFee = bucketList[i].deliveryFee;
      }

      productData.add(ShoppingBucketProduct(
          title: bucketList[i].title,
          image: bucketList[i].image,
          nickname: bucketList[i].nickname,
          productNo: bucketList[i].productNo,
          itemId: bucketList[i].itemId,
          price: bucketList[i].price,
          deliveryFee: bucketList[i].deliveryFee,
          sumDeliveryFee: sumDeliveryFee,
          itemCount: bucketList[i].itemCount,
          stock: bucketList[i].stock));

      debugPrint("image : " + bucketList[i].image);

      totalPrice(totalPrice.value +
          (productData[i].price * productData[i].itemCount) +
          productData[i].sumDeliveryFee);
    }
    bucketProducts.assignAll(productData);
    debugPrint("bucketProducts : " + bucketProducts.length.toString());

    loading(false);
  }
}
