class FavoriteProduct {
  final String image, title, nickname;
  final int productNo, price;

  FavoriteProduct({
    required this.productNo,
    required this.image,
    required this.title,
    required this.nickname,
    required this.price,
  });

  factory FavoriteProduct.fromJson(Map<String, dynamic> json) {
    return FavoriteProduct(
      productNo: json['productNo'],
      image: json['image'],
      title: json['title'],
      nickname: json['nickname'],
      price: json['price'],
    );
  }
}
