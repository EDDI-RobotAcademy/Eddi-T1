import 'package:flutter/material.dart';

import '../../../api/spring_product_api.dart';
import '../../../component/buyer/app_bar/no_logo_top_bar.dart';
import '../../../component/buyer/category/category_product.dart';
import '../../../component/buyer/category/category_product_list_from.dart';

bool isLoading = false;

class KnowhowPage extends StatefulWidget {
  const KnowhowPage({Key? key}) : super(key: key);

  @override
  State<KnowhowPage> createState() => _KnowhowPageState();
}

class _KnowhowPageState extends State<KnowhowPage> {
  @override
  void initState() {
    setState(() {
      isLoading = false;
    });
    super.initState();
    addProductList();
  }

  addProductList() async {
    List<RequestProductThumbnailInfo> productList =
        await SpringProductApi().firstProductList('노하우', 8);
    category_knowhow_list.clear();
    for (var i = 0; i < productList.length; i++) {
      RequestProductImage image = await SpringProductApi()
          .productThumbnailImage(productList[i].productNo);

      category_knowhow_list.add(CategoryProduct(
        productNo: productList[i].productNo,
        image: image.editedName,
        nickname: productList[i].nickname,
        title: productList[i].title,
        price: productList[i].price,
      ));
      debugPrint(category_knowhow_list.toString());
    }
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading == false) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0XFF2F4F4F),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: const NoLogoTopBar(),
        body: Column(
          children: [
            CategoryProductListForm(
              category_list: category_knowhow_list,
              categoryName: '노하우',
            )
          ],
        ),
      );
    }
  }
}
