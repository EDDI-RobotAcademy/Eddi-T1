class CategoryProduct {
  final String image, title, nickname;

  // 추후에 리뷰작업 진행되면 활성화 시킬 예정
  // final String starRate, reviewCount;
  final int productNo, price;

  CategoryProduct({
    required this.productNo,
    required this.image,
    required this.title,
    required this.nickname,
    required this.price,
    // required this.starRate,
    // required this.reviewCount,
  });
}

List<CategoryProduct> category_handmade_list = [];
List<CategoryProduct> category_knowhow_list = [];
List<CategoryProduct> category_hobby_list = [];
