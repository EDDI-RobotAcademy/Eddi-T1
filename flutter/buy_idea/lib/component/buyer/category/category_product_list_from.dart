import 'package:buy_idea/component/buyer/category/category_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/spring_product_api.dart';
import '../../../pages/buyer/product/product_details_page.dart';
import 'category_product_card.dart';

class CategoryProductListForm extends StatefulWidget {
  CategoryProductListForm(
      {Key? key, required this.category_list, required this.categoryName})
      : super(key: key);
  final List<CategoryProduct> category_list;
  final String categoryName;

  @override
  State<CategoryProductListForm> createState() =>
      _CategoryProductListFormState();
}

class _CategoryProductListFormState extends State<CategoryProductListForm> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.height / 1400,
            children: List.generate(widget.category_list.length, (index) {
              return CategoryProductCard(
                productNo: widget.category_list[index].productNo,
                title: widget.category_list[index].title,
                image: widget.category_list[index].image,
                price: widget.category_list[index].price,
                nickname: widget.category_list[index].nickname,
                // starRate: widget.category_list[index].starRate,
                // reviewCount: widget.category_list[index].reviewCount,
                press: () {
                  Get.to(ProductDetailsPage(
                      productNo: widget.category_list[index].productNo));
                },
              );
            })));
  }

  _scrollListener() async {
    if (_scrollController.offset >=
        _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {

      var productCount = widget.category_list.length;

      List<RequestProductThumbnailInfo> nextProductList =
      await SpringProductApi().nextProductList(
          widget.category_list[productCount-1].productNo, widget.categoryName, 4);

      for (var i = 0; i < nextProductList.length; i++) {
        RequestProductImage image = await SpringProductApi()
            .productThumbnailImage(nextProductList[i].productNo);

        widget.category_list.add(CategoryProduct(
          productNo: nextProductList[i].productNo,
          image: image.editedName,
          nickname: nextProductList[i].nickname,
          title: nextProductList[i].title,
          price: nextProductList[i].price,
        ));
        debugPrint(widget.category_list.toString());
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}