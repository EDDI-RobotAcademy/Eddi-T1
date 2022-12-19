import 'package:buy_idea/component/buyer/category/category_product.dart';
import 'package:flutter/material.dart';

import 'category_product_card.dart';

class CategoryProductListForm extends StatefulWidget {
  CategoryProductListForm({Key? key, required this.category_list}) : super(key: key);
  final List<CategoryProduct> category_list;

  @override
  State<CategoryProductListForm> createState() =>
      _CategoryProductListFormState();
}

class _CategoryProductListFormState extends State<CategoryProductListForm> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
            shrinkWrap: true,
            primary: true,
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.height / 1300,
            children: List.generate(widget.category_list.length, (index) {
              return CategoryProductCard(
                title: widget.category_list[index].title,
                image: widget.category_list[index].image,
                price: widget.category_list[index].price,
                nickname: widget.category_list[index].nickname,
                starRate: widget.category_list[index].starRate,
                reviewCount: widget.category_list[index].reviewCount,
                press: () {
                  //상품 누르면 상품 상세 정보로 이동
                },
              );
            })));
  }
}
