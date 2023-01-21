import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../api/spring_favorite_api.dart';
import '../../../../pages/buyer/product/product_details_page.dart';
import 'my_favorite_product.dart';
import 'my_favorite_product_card.dart';

class MyFavoriteForm extends StatefulWidget {
  const MyFavoriteForm({Key? key, required this.memberNickname})
      : super(key: key);
  final String memberNickname;

  @override
  State<MyFavoriteForm> createState() => _MyFavoriteFormState();
}

class _MyFavoriteFormState extends State<MyFavoriteForm> {
  bool isLoading = false;
  List<FavoriteProduct> favoriteList = [];

  @override
  void initState() {
    /// 장바구니 리스트 요청
    _requestMyFavoriteList();

    super.initState();
  }

  _requestMyFavoriteList() async {
    List<FavoriteProduct> list = await SpringFavoriteApi()
        .requestMyFavoriteProductList(widget.memberNickname);
    for (var i = 0; i < list.length; i++) {
      favoriteList.add(FavoriteProduct(
          productNo: list[i].productNo,
          image: list[i].image,
          title: list[i].title,
          nickname: list[i].nickname,
          price: list[i].price));
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(favoriteList.isEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 750,
        color: Colors.white,
        child: Center(
          child: Text(
              '찜한 아이디어 상품이 없습니다.',
              style: TextStyle(fontSize: 16)
          ),
        ),
      );
    }else{
    return Expanded(
        child: Stack(
      children: [
        GridView.count(
            padding: const EdgeInsets.only(bottom: 20),
            scrollDirection: Axis.vertical,
            crossAxisCount: 2,
            childAspectRatio: MediaQuery.of(context).size.height / 1400,
            children: List.generate(favoriteList.length, (index) {
              return MyFavoriteProductCard(
                productNo: favoriteList[index].productNo,
                title: favoriteList[index].title,
                image: favoriteList[index].image,
                price: favoriteList[index].price,
                nickname: favoriteList[index].nickname,
                press: () {
                  Get.to(ProductDetailsPage(productNo: favoriteList[index].productNo, isFavorite: 'myFavorite'));
                },
              );
            })),
        if (!isLoading)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: SpinKitThreeBounce(
                  color: Color(0xff2F4F4F),
                  size: 25,
                ),
              ),
            ],
          )
      ],
    ));

    }

  }
}
