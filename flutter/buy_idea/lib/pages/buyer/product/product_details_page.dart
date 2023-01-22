import 'package:buy_idea/api/spring_product_api.dart';
import 'package:buy_idea/api/spring_review_api.dart';
import 'package:buy_idea/component/buyer/product/product_details_page_header.dart';
import 'package:buy_idea/component/buyer/product/product_details_page_image_view.dart';
import 'package:buy_idea/component/buyer/product/product_info_form.dart';
import 'package:buy_idea/component/buyer/product/product_buy_and_shopping_cart_select_modal_sheet.dart';
import 'package:buy_idea/component/buyer/product/review/product_review_form.dart';
import 'package:buy_idea/pages/account/sign_in_page.dart';
import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:buy_idea/pages/buyer/my_info/my_favorite/my_favorite_page.dart';
import 'package:buy_idea/pages/buyer/shopping_bucket/shopping_bucket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../../../api/spring_favorite_api.dart';
import '../../../component/buyer/product/QnA/product_qna_form.dart';
import '../../../component/common/yes_or_no_alert_dialog.dart';
import 'favorite_controller.dart';

class ProductDetailsPage extends StatefulWidget {
  final int productNo;
  final String? memberType;
  final String? isFavorite;

  const ProductDetailsPage(
      {Key? key, required this.productNo, this.memberType, this.isFavorite})
      : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage>
    with TickerProviderStateMixin {
  static const storage = FlutterSecureStorage();
  final favoriteController = Get.put(FavoriteController(), permanent: true);
  dynamic nickname = '';

  _asyncMethod() async {
    nickname = await storage.read(key: 'nickname');
    debugPrint('불러온 닉네임 : $nickname');
    if (nickname == null) {
      setState(() {
        nickname = '비회원';
      });
    } else {
      setState(() {
        nickname;
      });
    }
  }

  late TabController tabController;

  late RequestProduct product;
  late List<RequestProductImage> productImageList;
  final int freeDeliveryFee = 50000;

  int reviewCount = 0;
  double starRatingAverage = 0.0;
  bool favoriteStatus = false;

  Future<void> _requestReviewCountAndStarRating() async {
    reviewCount = await SpringReviewApi().reviewCount(widget.productNo);
    starRatingAverage =
        await SpringReviewApi().averageOfStarRating(widget.productNo);
  }

  @override
  void initState() {
    super.initState();
    _asyncMethod();
    tabController = TabController(length: 3, vsync: this);
    _requestProduct();
    _requestReviewCountAndStarRating();
  }

  Future<void> _requestProduct() async {
    product = await SpringProductApi().productDetailsInfo(widget.productNo);
    productImageList =
        await SpringProductApi().productImageList(widget.productNo);
    await _getFavoriteStatus();
  }

  Widget _tabMenu(String menu) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(menu, style: TextStyle(fontSize: 13, color: Colors.black)),
    );
  }

  _getFavoriteStatus() async {
    /// 찜 상태 조회
    FavoriteRequest request =
        FavoriteRequest(widget.productNo, nickname, "findFavorite");
    await SpringFavoriteApi().requestFavoriteStatus(request);
    FavoriteController().setFavoriteStatus();
  }

  Future<bool> _tapFavoriteButton(bool isLiked) async {
    if (nickname != '비회원') {
      /// 비회원 아닐 때 찜 누름
      FavoriteRequest request =
          FavoriteRequest(widget.productNo, nickname, "tapFavorites");
      await SpringFavoriteApi().requestFavoriteStatus(request);
      FavoriteController().setFavoriteStatus();
      return !isLiked;
    } else {
      /// 비회원일 때 로그인해야 함
      _signInShowDialog();
      return isLiked;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // _requestProduct() 메소드가 완료 될 때까지 로딩표시를 띄우기 위한 FutureBuilder
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
                    leading: widget.isFavorite == 'myFavorite'
                        ? IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Get.back();
                              Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyFavoritePage(
                                              nickname: nickname)))
                                  .then((value) => setState(() {}));
                            })
                        : IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: Icon(Icons.arrow_back)),
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    title: widget.memberType != '판매자'
                        ? GestureDetector(
                            child: Image.asset('assets/buydia_logo.png',
                                width: 80, height: 50),
                            onTap: () {
                              Get.offAll(MainPage());
                            },
                          )
                        : Image.asset('assets/buydia_logo.png',
                            width: 80, height: 50),
                    elevation: 0,
                    actions: widget.memberType != '판매자'
                        ? [
                            IconButton(
                                onPressed: () {
                                  Get.to(ShoppingBucketPage());
                                },
                                icon: const Icon(Icons.shopping_cart_outlined)),
                          ]
                        : null),
                body: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              ProductDetailsPageImageView(
                                  imageList: productImageList),
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
                      SliverToBoxAdapter(child: SizedBox(height: 20)),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: TabBarDelegate(
                            widget: Container(
                          height: AppBar().preferredSize.height,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12),
                                  top: BorderSide(color: Colors.black12))),
                          child: TabBar(
                            controller: tabController,
                            indicatorColor: Color(0xff2F4F4F),
                            tabs: [
                              _tabMenu('상품 정보'),
                              _tabMenu('구매 후기'),
                              _tabMenu('문의')
                            ],
                          ),
                        )),
                      ),
                    ];
                  },
                  body: widget.memberType != '판매자'
                      ? Padding(
                          padding: EdgeInsets.only(bottom: 60),
                          child:
                              TabBarView(controller: tabController, children: [
                            ProductInfoForm(content: product.content),
                            ProductReviewForm(
                                productNo: widget.productNo,
                                reviewSize: 3,
                                nextReviewSize: 5,
                                reviewCount: reviewCount),
                            ProductQnaForm(
                              productNo: widget.productNo,
                              title: product.title,
                              image: productImageList[0].editedName,
                              nickname: product.nickname,
                            ),
                          ]),
                        )
                      : TabBarView(controller: tabController, children: [
                          ProductInfoForm(content: product.content),
                          ProductReviewForm(
                              productNo: widget.productNo,
                              reviewSize: 3,
                              nextReviewSize: 5,
                              reviewCount: reviewCount),
                          ProductQnaForm(
                            productNo: widget.productNo,
                            title: product.title,
                            image: productImageList[0].editedName,
                            nickname: product.nickname,
                          ),
                        ]),
                ),
                bottomSheet: widget.memberType != '판매자'
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border(top: BorderSide(color: Colors.black12))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              child: Center(
                                child: LikeButton(
                                  onTap: _tapFavoriteButton,
                                  size: 55,
                                  likeBuilder: (bool isLiked) {
                                    return Icon(
                                      Icons.lightbulb,
                                      size: 40,
                                      color: FavoriteController
                                              .productFavoriteStatus
                                          ? Color(0xFFffc81c)
                                          : Colors.grey,
                                    );
                                  },
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10))),
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
                                    });
                              },
                              child: Text('구매하기'),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  fixedSize: Size(320, 45),
                                  primary: Color(0xff2F4F4F)),
                            ),
                          ],
                        ),
                      )
                    : null
            );
          }
        });
  }

  /// 로그인 안내 alertDialog
  void _signInShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return YesOrNoAlertDialog(
            title: "⚠️",
            content: '로그인이 필요한 서비스입니다. \n로그인 페이지로 이동하시겠습니까?',
            yesButtonPressed: () {
              Get.to(const SignInPage());
            },
            noButtonPressed: () {
              Get.back();
            },
          );
        });
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
