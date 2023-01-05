import 'package:buy_idea/api/spring_product_api.dart';
import 'package:buy_idea/component/buyer/product/product_details_page_header.dart';
import 'package:buy_idea/component/buyer/product/product_details_page_image_view.dart';
import 'package:buy_idea/component/buyer/product/product_info_form.dart';
import 'package:buy_idea/component/buyer/product/product_buy_and_shopping_cart_select_modal_sheet.dart';
import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:buy_idea/pages/buyer/shopping_bucket/shopping_bucket_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
/*  final List<String> imageList = [
    'assets/product/handmade1.jpg',
    'assets/product/handmade2.jpg',
    'assets/product/handmade3.jpg',
    'assets/product/handmade4.jpg',
    'assets/product/hobby1.jpg',
    'assets/product/hobby2.jpg',
    'assets/product/hobby3.jpg',
    'assets/product/hobby4.jpg',
  ];
  final String seller = '야옹아 멍멍해봐';
  final String productTitle = '선물추천♡ 볼 통통한 토끼 "볼토" 키링';
  final int productPrice = 28600;
  final int shippingCost = 2500;
  final int freeShippingCost = 50000;
  final String productContent =
  '''
  귀엽고 앙증맞은
볼 통통한 토끼 "볼토"를 소개합니다.



오동통한 볼을 콱!!
깨물어 주고 싶은 "볼토" (볼 통통한 토끼)
조그마한 아이라 가방에도 쏘옥~ 들어간답니다.
애착인형으로~ 반려인형으로~



볼토에 키 링을 달아 언제나 함께 할 수도 있어요.
아이들 가방에도
잊어버리기 쉬운 열쇠고리에도
자동차 키에도
귀여운 볼토 함께해요.
선물용으로도 좋아요~ ^^




헤라 코튼 실로 뜬 보들보들한 쪼꼬미 인형이에요.

헤라 코튼(제일모직)
cotton 55%
A/A 45%
Wool 5%
made in Korea






추가 상품
1. D 모양 키 링
2. D 모양 키 링 + 아크릴 장식(꽃, 나무)




볼토 주재료 : 코튼사, 방울 솜, 인형 눈, 자수실
볼토 부재료 : D 모양 키 링, 아크릴 장식


주문 후 제작되는 상품으로 3~5일 정도 소요될 수 있습니다.
세탁은 중성세제를 이용해 손세탁 후 자연건조해 주세요.
(세탁 후 볼 터치가 지워지면 블러셔로 톡톡해주셔도 좋습니다. ^^)




손안에 폭~ 들어오는 사이즈

(볼토 사이즈)
가로 8cm * 세로 10cm
핸드메이드 특성상 사이즈 오차가 있을 수 있습니다. (±0.5cm)
  '''; */

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    _requestProduct();
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
                      Text('구매 후기'),
                      Text('문의'),
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
