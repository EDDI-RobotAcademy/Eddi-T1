import 'package:buy_idea/pages/buyer/main_menu/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../pages/buyer/shopping_bucket/shopping_bucket_page.dart';

class NoLogoTopBar extends StatelessWidget with PreferredSizeWidget {
  const NoLogoTopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: TextButton.icon(
              icon: const Text("검색어를 입력하세요.",
                  style: TextStyle(color: Colors.grey)),
              label: const Padding(
                padding: EdgeInsets.only(left: 130.0),
                child: Icon(Icons.search, color: Colors.black),
              ),
              onPressed: () {
                Get.to(SearchPage());
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  side: const BorderSide(color: Colors.grey, width: 1.0),
                  primary: Colors.white,
                  minimumSize: Size(280, 10))),
        ),
        const SizedBox(width: 5.0),
        IconButton(
            onPressed: () {
              Get.to(ShoppingBucketPage());
            },
            icon: const Icon(Icons.add_shopping_cart_outlined)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
