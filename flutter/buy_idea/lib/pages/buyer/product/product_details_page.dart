import 'package:buy_idea/api/spring_product_api.dart';
import 'package:buy_idea/api/spring_review_api.dart';
import 'package:buy_idea/component/buyer/product/product_details_page_header.dart';
import 'package:buy_idea/component/buyer/product/product_details_page_image_view.dart';
import 'package:buy_idea/component/buyer/product/product_info_form.dart';
import 'package:buy_idea/component/buyer/product/product_buy_and_shopping_cart_select_modal_sheet.dart';
import 'package:buy_idea/component/buyer/product/review/product_review_form.dart';
import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:buy_idea/pages/buyer/shopping_bucket/shopping_bucket_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/buyer/product/QnA/product_qna_form.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productNo;
  const ProductDetailsPage({Key? key, required this.productNo}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with TickerProviderStateMixin {

  late TabController tabController;

  late RequestProduct product;
  late List<RequestProductImage> productImageList;
  final int freeDeliveryFee = 50000;

  int reviewCount = 0;
  double starRatingAverage = 0.0;

  Future<void> _requestReviewCountAndStarRating() async {
    reviewCount = await SpringReviewApi().reviewCount(widget.productNo);
    starRatingAverage = await SpringReviewApi().averageOfStarRating(widget.productNo);
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _requestProduct();
    _requestReviewCountAndStarRating();
  }

  Future<void> _requestProduct() async {
    product = await SpringProductApi().productDetailsInfo(widget.productNo);
    productImageList = await SpringProductApi().productImageList(widget.productNo);
  }

  Widget _tabMenu(String menu) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
          menu,
          style: TextStyle(fontSize: 13, color: Colors.black)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder( // _requestProduct() 메소드가 완료 될 때까지 로딩표시를 띄우기 위한 FutureBuilder
      future: _requestProduct(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // 메소드가 완료되지 않았다면 로딩표시 애니메이션을 화면에 띄움
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff2F4F4F),
              ),
            ),
          );
        } else {
          // 메소드가 완료됐다면 띄워지는 UI
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              centerTitle: true,
              title: GestureDetector(
                child: Image.asset('assets/buydia_logo.png', width: 80, height: 50),
                onTap: () {
                    Get.offAll(MainPage());
                },
              ),
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.to(ShoppingBucketPage());
                    },
                    icon: const Icon(Icons.shopping_cart_outlined)
                ),
              ],
            ),
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverToBoxAdapter(
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ProductDetailsPageImageView(imageList: productImageList),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ProductDetailsPageHeader(
                              seller: product.nickname,
                              productTitle: product.title,
                              productPrice: product.price,
                              deliveryFee: product.deliveryFee,
                              freeDeliveryFee: freeDeliveryFee,
                              stock: product.stock,
                              starRatingAverage: starRatingAverage,
                              reviewCount: reviewCount,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                      child: SizedBox(height: 20)
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: TabBarDelegate(
                        widget: Container(
                          height: AppBar().preferredSize.height,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12),
                                  top: BorderSide(color: Colors.black12)
                              )
                          ),
                          child: TabBar(
                            controller: tabController,
                            indicatorColor: Color(0xff2F4F4F),
                            tabs: [
                              _tabMenu('상품 정보'),
                              _tabMenu('구매 후기'),
                              _tabMenu('문의')
                            ],
                          ),
                        )
                    ),
                  ),
                ];
              },
              body: Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: TabBarView(
                    controller: tabController,
                    children: [
                      ProductInfoForm(content: product.content),
                      ProductReviewForm(productNo: widget.productNo, reviewSize: 3, nextReviewSize: 5, reviewCount: reviewCount),
                      ProductQnaForm(productNo: widget.productNo, title: product.title, image: productImageList[0].editedName, nickname: product.nickname,),
                    ]
                ),
              ),
            ),
            bottomSheet: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)
                              )
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return ProductBuyAndShoppingCartSelectModalSheet(
                              seller: product.nickname,
                              productTitle: product.title,
                              productPrice: product.price,
                              deliveryFee: product.deliveryFee,
                              freeDeliveryFee: freeDeliveryFee,
                              stock: product.stock,
                              productNo: product.productNo,
                            );
                          }
                      );
                    },
                    child: Text('구매하기'),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(300, 45),
                        primary: Color(0xff2F4F4F)
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  TabBarDelegate({required this.widget});
  Widget widget;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => AppBar().preferredSize.height;

  @override
  double get minExtent => AppBar().preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
