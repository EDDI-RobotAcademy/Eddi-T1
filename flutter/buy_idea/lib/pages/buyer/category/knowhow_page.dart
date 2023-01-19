
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../api/spring_product_api.dart';
import '../../../component/buyer/app_bar/no_logo_top_bar.dart';
import '../../../component/buyer/category/category_product.dart';
import '../../../component/buyer/category/category_product_list_from.dart';

class KnowhowPage extends StatefulWidget {
  const KnowhowPage({Key? key}) : super(key: key);

  @override
  State<KnowhowPage> createState() => _KnowhowPageState();
}

class _KnowhowPageState extends State<KnowhowPage> {

  bool isLoading = false;

  String viewMode = '최신순';
  List<String> dropdownItemList = ['최신순', '인기순', '후기순', '높은 가격순', '낮은 가격순'];

  List<int> productNoList = [];

  @override
  void initState() {
    super.initState();
    addProductList(viewMode);
  }

  addProductList(String viewMode) async {
    setState(() {
      isLoading = false;
    });
    List<RequestProductThumbnailInfo> productList =
        await SpringProductApi().firstProductList('노하우', 8, viewMode);
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
      productNoList.add(productList[i].productNo);
      debugPrint(category_knowhow_list.toString());
    }
    setState(() {
      productNoList;
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
            Container(
              width: MediaQuery.of(context).size.width,
              height: 40,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton2(
                    value: viewMode,
                    items: dropdownItemList.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold
                          ),
                        )
                    )).toList(),
                    onChanged: (String? item) {
                      setState(() {
                        viewMode = item!;
                        addProductList(viewMode);
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 20,
                    buttonWidth: 120,
                    buttonHeight: 50,
                    buttonPadding: EdgeInsets.all(5),
                  ),
                  SizedBox(width: 10)
                ],
              ),
            ),
            CategoryProductListForm(
              category_list: category_knowhow_list,
              categoryName: '노하우',
              viewMode: viewMode,
              productNoList: productNoList,
            )
          ],
        ),
      );
    }
  }
}
