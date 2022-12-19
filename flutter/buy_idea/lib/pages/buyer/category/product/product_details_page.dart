import 'package:buy_idea/component/buyer/category/product/product_details_page_header.dart';
import 'package:buy_idea/component/buyer/category/product/product_details_page_image_view.dart';
import 'package:flutter/material.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> with TickerProviderStateMixin {

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
          ];
        },
        body: Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: Container(),
        ),
      ),
    );
  }
}
