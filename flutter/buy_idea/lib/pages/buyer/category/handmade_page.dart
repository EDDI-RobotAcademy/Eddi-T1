import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/no_logo_top_bar.dart';
import '../../../component/buyer/category/category_product.dart';
import '../../../component/buyer/category/category_product_list_from.dart';

class HandmadePage extends StatefulWidget {
  const HandmadePage({Key? key}) : super(key: key);

  @override
  State<HandmadePage> createState() => _HandmadePageState();
}

class _HandmadePageState extends State<HandmadePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NoLogoTopBar(),
      body: Column(
        children: [
          CategoryProductListForm(category_list: category_handmade_list)
        ],
      ),
    );
  }
}
