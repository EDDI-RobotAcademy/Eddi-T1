import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/top_bar.dart';
import '../../../component/buyer/category/category_product.dart';
import '../../../component/buyer/category/category_product_list_from.dart';

class KnowhowPage extends StatefulWidget {
  const KnowhowPage({Key? key}) : super(key: key);

  @override
  State<KnowhowPage> createState() => _KnowhowPageState();
}

class _KnowhowPageState extends State<KnowhowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Column(
        children: [
          CategoryProductListForm(category_list: category_knowhow_list)
        ],
      ),
    );
  }
}
