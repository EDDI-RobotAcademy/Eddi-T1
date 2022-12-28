import 'package:buy_idea/component/buyer/home/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/spring_product_api.dart';
import '../../../pages/buyer/product/product_details_page.dart';
import 'home_product_list.dart';

bool load = false;

class HomeCategoryProduct extends StatefulWidget {
  HomeCategoryProduct(
      {Key? key, required this.nicknameInfo, required this.category})
      : super(key: key);

  @override
  State<HomeCategoryProduct> createState() => _HomeHandmadeState();
  final String nicknameInfo;
  final String category;
}

class _HomeHandmadeState extends State<HomeCategoryProduct> {
  @override
  void initState() {
    setState(() {
      load = false;
    });
    super.initState();
    addProductList();
  }

  var category_list;

  addProductList() async {
    List<RequestProductThumbnailInfo> productList =
        await SpringProductApi().firstProductList(widget.category, 4);
    switch (widget.category) {
      case "핸드메이드":
        home_handmade_list.clear();
        for (var i = 0; i < productList.length; i++) {
          RequestProductImage image = await SpringProductApi()
              .productThumbnailImage(productList[i].productNo);

          home_handmade_list.add(HomeProduct(
            productNo: productList[i].productNo,
            image: image.editedName,
            title: productList[i].title,
          ));
          debugPrint(category_list.toString());
        }
        category_list = home_handmade_list;
        break;
      case "노하우":
        home_knowhow_list.clear();
        for (var i = 0; i < productList.length; i++) {
          RequestProductImage image = await SpringProductApi()
              .productThumbnailImage(productList[i].productNo);

          home_knowhow_list.add(HomeProduct(
            productNo: productList[i].productNo,
            image: image.editedName,
            title: productList[i].title,
          ));
          debugPrint(category_list.toString());
        }
        category_list = home_knowhow_list;
        break;
      case "취미/특기":
        home_hobby_list.clear();
        for (var i = 0; i < productList.length; i++) {
          RequestProductImage image = await SpringProductApi()
              .productThumbnailImage(productList[i].productNo);

          home_hobby_list.add(HomeProduct(
            productNo: productList[i].productNo,
            image: image.editedName,
            title: productList[i].title,
          ));
          debugPrint(category_list.toString());
        }
        category_list = home_hobby_list;
        break;
    }
    setState(() {
      load = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (load == false) {
      return const Padding(
        padding: EdgeInsets.all(100),
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0XFF2F4F4F),
          ),
        ),
      );
    } else {
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
                child: HomeProductCard(
                  title: category_list[index].title,
                  image: category_list[index].image,
                  press: () {
                    Get.to(ProductDetailsPage(
                        productNo: category_list[index].productNo));
                  },
                ),
              ),
            ),
          ),
        ),
      ]);
    }
  }
}
