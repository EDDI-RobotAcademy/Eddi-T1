class HomeProduct {
  final String image, title;
  final int productNo;

  HomeProduct({
    required this.image,
    required this.productNo,
    required this.title,

  });
}

List<HomeProduct> home_handmade_list = [];
List<HomeProduct> home_knowhow_list = [];
List<HomeProduct> home_hobby_list = [];