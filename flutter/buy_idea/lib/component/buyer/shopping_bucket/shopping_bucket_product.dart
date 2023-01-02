class ShoppingBucketProduct {
  String title, image, nickname;
  int productNo, price, deliveryFee, itemCount, stock, sumDeliveryFee;

  ShoppingBucketProduct({
    required this.title,
    required this.image,
    required this.nickname,
    required this.productNo,
    required this.price,
    required this.deliveryFee,
    required this.sumDeliveryFee,
    required this.itemCount,
    required this.stock,
  });

  factory ShoppingBucketProduct.fromJson(Map<String, dynamic> json) {
    return ShoppingBucketProduct(
        title: json['product']['title'],
        image: json['product']['productImages'][0]['editedName'],
        nickname: json['product']['nickname'],
        productNo: json['product']['productNo'],
        price: json['product']['price'],
        deliveryFee: json['product']['productInfo']['deliveryFee'],
        sumDeliveryFee: json['product']['productInfo']['deliveryFee'],
        itemCount: json['itemCount'],
        stock: json['product']['productInfo']['stock']);
  }
}
