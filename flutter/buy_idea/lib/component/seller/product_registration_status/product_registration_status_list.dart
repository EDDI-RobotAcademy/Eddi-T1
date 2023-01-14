import 'dart:async';

import 'package:buy_idea/api/seller/spring_seller_product_api.dart';
import 'package:buy_idea/pages/buyer/product/product_details_page.dart';
import 'package:buy_idea/utility/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductRegistrationStatusList extends StatefulWidget {

  final String seller;
  final String category;
  final int listSize;
  final int nextListSize;

  const ProductRegistrationStatusList({
    Key? key,
    required this.seller,
    required this.category,
    required this.listSize,
    required this.nextListSize
  }) : super(key: key);

  @override
  State<ProductRegistrationStatusList> createState() => _ProductRegistrationStatusListState();
}

class _ProductRegistrationStatusListState extends State<ProductRegistrationStatusList> {

  List<RequestSellerProduct> productList = [];
  var future;

  var f = NumberFormat('###,###,###,###');

  _requestSellerProductList() async {
    productList = await SpringSellerProductApi().sellerProductList(
        widget.seller, widget.category, widget.listSize);
  }

  final ScrollController _scrollController = ScrollController();

  bool isLoading = false;

  @override
  void initState() {
    future = _requestSellerProductList();
    _scrollController.addListener(() {
      _scrollListener();
    });
    super.initState();
  }

  _scrollListener() async {
    debugPrint("offset : ${_scrollController.offset}");
    if (_scrollController.offset == _scrollController.position.maxScrollExtent
        && !_scrollController.position.outOfRange) {
      setState(() {
        isLoading = true;
      });
      List<RequestSellerProduct> nextProductList = await SpringSellerProductApi()
          .sellerNextProductList(
          widget.seller, widget.category,
          productList[productList.length - 1].productNo, widget.nextListSize);
      for (RequestSellerProduct product in nextProductList) {
        productList.add(product);
      }
      debugPrint('스크롤이 맨 아래에 위치해 있습니다');
      Timer(Duration(milliseconds: 1300), () {
        setState(() {
          productList;
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return LoadingScreen(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height
          );
        } else {
          return Stack(
            children: [
              ListView.builder(
                padding: EdgeInsets.only(bottom: 30),
                controller: _scrollController,
                itemCount: productList.length,
                itemBuilder: (BuildContext buildContext, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          Get.to(ProductDetailsPage(productNo: productList[index].productNo, seller: productList[index].seller));
                        },
                        child: Container(
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 180,
                                  height: 180,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/product/${productList[index].productImage}')
                                    ),
                                    borderRadius: BorderRadius.circular(15)
                                  ),
                                ),
                                VerticalDivider(),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          productList[index].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 12,)
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Divider(thickness: 1, height: 10),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.paid_outlined,
                                                  color: Colors.black,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  f.format(productList[index].price),
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                        '가격',
                                                        style: TextStyle(fontSize: 12),
                                                        textAlign: TextAlign.end
                                                    )
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.local_shipping_outlined,
                                                  color: Colors.black,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  f.format(productList[index].deliveryFee),
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                        '배송비',
                                                        style: TextStyle(fontSize: 12),
                                                        textAlign: TextAlign.end
                                                    )
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.shopping_basket_outlined,
                                                  color: Colors.black,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  f.format(productList[index].stock),
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                Expanded(
                                                    child: Text(
                                                        '상품 수량',
                                                        style: TextStyle(fontSize: 12),
                                                        textAlign: TextAlign.end
                                                    )
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star_rate,
                                                  color: Colors.amber,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  productList[index].starRatingAverage.toString(),
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '별점',
                                                    style: TextStyle(fontSize: 12),
                                                    textAlign: TextAlign.end
                                                  )
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.rate_review_outlined,
                                                  color: Colors.black,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  productList[index].reviewCount.toString(),
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '후기',
                                                    style: TextStyle(fontSize: 12),
                                                    textAlign: TextAlign.end
                                                  )
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.event_available,
                                                  color: Colors.black,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  DateFormat('yyyy/MM/dd').format(DateTime.parse(productList[index].regDate)),
                                                  style: TextStyle(fontSize: 12)
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '등록일',
                                                    style: TextStyle(fontSize: 12),
                                                    textAlign: TextAlign.end,
                                                  )
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.edit_calendar,
                                                  color: Colors.black,
                                                  size: 14,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                    DateFormat('yyyy/MM/dd').format(DateTime.parse(productList[index].updDate)),
                                                    style: TextStyle(fontSize: 12)
                                                ),
                                                Expanded(
                                                    child: Text(
                                                      '수정일',
                                                      style: TextStyle(fontSize: 12),
                                                      textAlign: TextAlign.end,
                                                    )
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                )
                              ],
                            ),
                          )
                        ),
                      ),
                    ),
                  );
              }),
              if (isLoading)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SpinKitThreeBounce(
                        color: Color(0xff2F4F4F),
                        size: 25,
                      ),
                    ),
                  ],
                )
            ],
          );
        }
      }
    );
  }
}
