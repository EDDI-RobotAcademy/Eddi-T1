import 'package:buy_idea/component/buyer/home/product_card.dart';
import 'package:flutter/cupertino.dart';

import 'handmade_product.dart';

class HomeCategoryProduct extends StatefulWidget {
  HomeCategoryProduct({Key? key, required this.nicknameInfo, required this.category}) : super(key: key);

  @override
  State<HomeCategoryProduct> createState() => _HomeHandmadeState();
  final String nicknameInfo;
  final String category;
}

class _HomeHandmadeState extends State<HomeCategoryProduct> {


  @override
  Widget build(BuildContext context) {
    var category_list;
    switch(widget.category){
      case "핸드메이드" :
        category_list = handmade_list;
        break;
      case "직업 노하우" :
        category_list = knowhow_list;
        break;
      case "취미/특기" :
        category_list = hobby_list;
        break;
    }


    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Text(
            "🎁 " + widget.nicknameInfo + "님을 위한 " + widget.category + " 상품",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            category_list.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: ProductCard(
                title: category_list[index].title,
                image: category_list[index].image,
                bgColor: category_list[index].bgColor,
                press: () {
                  //상품 누르면 상품 상세 정보로 이동
                },
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
