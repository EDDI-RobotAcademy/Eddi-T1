import 'package:buy_idea/component/buyer/category/category_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/spring_product_api.dart';
import '../../../component/buyer/app_bar/search_bar.dart';
import '../../../component/buyer/category/category_product_card.dart';
import '../product/product_details_page.dart';

bool isLoading = false;

class SearchListPage extends StatefulWidget {
  const SearchListPage({Key? key, required this.searchKeyword})
      : super(key: key);

  final String searchKeyword;

  @override
  State<SearchListPage> createState() => _SearchListPageState();
}

class _SearchListPageState extends State<SearchListPage> {
  @override
  void initState() {
    setState(() {
      isLoading = false;
    });
    super.initState();
    addSearchList();
  }

  addSearchList() async {
    List<CategoryProduct> productList =
        await SpringProductApi().searchProduct(widget.searchKeyword);
    searchList.clear();
    for (var i = 0; i < productList.length; i++) {
      searchList.add(CategoryProduct(
        productNo: productList[i].productNo,
        image: productList[i].image,
        nickname: productList[i].nickname,
        title: productList[i].title,
        price: productList[i].price,
      ));
      debugPrint(searchList.toString());
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == false) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0XFF2F4F4F),
          ),
        ),
      );
    } else {
      return Scaffold(
          appBar: SearchBar(searchKeyword: widget.searchKeyword),
          body: Column(
            children: [
              Expanded(
                  child: GridView.count(
                      shrinkWrap: true,
                      primary: true,
                      crossAxisCount: 2,
                      childAspectRatio:
                          MediaQuery.of(context).size.height / 1400,
                      children: List.generate(searchList.length, (index) {
                        return CategoryProductCard(
                          productNo: searchList[index].productNo,
                          title: searchList[index].title,
                          image: searchList[index].image,
                          price: searchList[index].price,
                          nickname: searchList[index].nickname,
                          press: () {
                            Get.to(ProductDetailsPage(
                                productNo: searchList[index].productNo));
                          },
                        );
                      }))),
            ],
          ));
    }
  }
}
