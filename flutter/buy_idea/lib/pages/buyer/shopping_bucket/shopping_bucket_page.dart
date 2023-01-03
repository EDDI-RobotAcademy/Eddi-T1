import 'package:buy_idea/component/buyer/app_bar/title_top_bar.dart';
import 'package:flutter/material.dart';

import '../../../component/buyer/shopping_bucket/shopping_bucket_form.dart';
import '../../../component/buyer/shopping_bucket/total_price_bottom.dart';

class ShoppingBucketPage extends StatefulWidget {
  const ShoppingBucketPage({Key? key}) : super(key: key);

  @override
  State<ShoppingBucketPage> createState() => _ShoppingBucketPageState();
}

class _ShoppingBucketPageState extends State<ShoppingBucketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.grey[100],
        appBar: const TitleTopBar(titleText: '장바구니'),
        body: Column(children: const [
          ShoppingBucketForm(),
          TotalPriceBottom(),
        ]));
  }
}
