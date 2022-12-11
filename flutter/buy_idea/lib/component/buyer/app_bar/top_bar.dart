import 'package:buy_idea/component/common/app_bar/bottom_bar.dart';
import 'package:buy_idea/pages/buyer/main_menu/search_page.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: GestureDetector(
          child: Image.asset("assets/buydia_logo.png", width: 80, height: 50),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const BottomBar();
            }));
          }),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: TextButton.icon(
              icon: const Text("검색어를 입력하세요.",
                  style: TextStyle(color: Colors.grey)),
              label: Padding(
                padding: const EdgeInsets.only(left: 80.0),
                child: Icon(Icons.search, color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage()));
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  side: BorderSide(color: Colors.grey, width: 1.0),
                  primary: Colors.white,
                  minimumSize: Size(260, 10))),
        ),
        SizedBox(width: 5.0),
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add_shopping_cart_outlined)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
