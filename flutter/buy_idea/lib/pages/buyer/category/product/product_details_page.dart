import 'package:buy_idea/component/buyer/category/product/product_details_page_header.dart';
import 'package:buy_idea/component/buyer/category/product/product_details_page_image_view.dart';
import 'package:buy_idea/component/buyer/category/product/product_info_form.dart';
import 'package:buy_idea/component/buyer/category/product/product_buy_and_shopping_cart_select_modal_sheet.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with TickerProviderStateMixin {

  late TabController tabController;

  final List<String> imageList = [
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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
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
    return Scaffold(
      appBar: AppBar(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ProductDetailsPageImageView(imageList: imageList),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ProductDetailsPageHeader(
                        seller: seller,
                        productTitle: productTitle,
                        productPrice: productPrice,
                        shippingCost: shippingCost,
                        freeShippingCost: freeShippingCost,
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
                Text('상품 정보'),
                Text('구매 후기'),
                Text('문의'),
              ]
          ),
        ),
      ),
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
