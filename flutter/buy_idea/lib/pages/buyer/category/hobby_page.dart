import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/no_logo_top_bar.dart';
import '../../../component/buyer/category/category_product.dart';
import '../../../component/buyer/category/category_product_list_from.dart';

class HobbyPage extends StatefulWidget {
  const HobbyPage({Key? key}) : super(key: key);

  @override
  State<HobbyPage> createState() => _HobbyPageState();
}

class _HobbyPageState extends State<HobbyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NoLogoTopBar(),
      body: Column(
        children: [CategoryProductListForm(category_list: category_hobby_list)],
      ),
    );
  }
}
