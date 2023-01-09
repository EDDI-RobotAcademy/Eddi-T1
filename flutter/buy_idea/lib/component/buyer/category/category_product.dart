class CategoryProduct {
  final String image, title, nickname;

  final int productNo, price;

  CategoryProduct({
    required this.productNo,
    required this.image,
    required this.title,
    required this.nickname,
    required this.price,
  });

  factory CategoryProduct.fromJson(Map<String, dynamic> json) {
    return CategoryProduct(
        title: json['title'],
        image: json['productImages'][0]['editedName'],
        nickname: json['nickname'],
        productNo: json['productNo'],
        price: json['price']);
  }
}

List<CategoryProduct> category_handmade_list = [];
List<CategoryProduct> category_knowhow_list = [];
List<CategoryProduct> category_hobby_list = [];
List<CategoryProduct> searchList = [];



