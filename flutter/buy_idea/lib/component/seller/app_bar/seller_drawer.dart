import 'package:buy_idea/pages/seller/product_registration_status/product_registration_status_page.dart';
import 'package:buy_idea/pages/seller/qna_management/qna_management_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../pages/seller/my_info/seller_my_info_page.dart';
import '../../../pages/seller/seller_main_page.dart';

class SellerDrawer extends StatefulWidget {
  const SellerDrawer({Key? key, required this.nickname}) : super(key: key);

  final String nickname;

  @override
  State<SellerDrawer> createState() => _SellerDrawerState();
}

class _SellerDrawerState extends State<SellerDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      AssetImage('assets/default_profile_image.png'),
                  backgroundColor: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  widget.nickname,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            decoration: BoxDecoration(
                color: Color(0xff2F4F4F),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
          ),
          SizedBox(height: 30),
          ListTile(
            onTap: () {
              Get.to(SellerMainPage());
            },
            leading: Icon(Icons.house_siding_outlined, color: Colors.black),
            title: Text('Home'),
            trailing: Icon(Icons.navigate_next, color: Colors.black),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Get.to(SellerMyInfoPage());
            },
            leading: Icon(Icons.account_box_outlined, color: Colors.black),
            title: Text('내 정보'),
            trailing: Icon(Icons.navigate_next, color: Colors.black),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Get.to(ProductRegistrationStatusPage(
                nickname: widget.nickname,
              ));
            },
            leading: Icon(Icons.local_mall_outlined, color: Colors.black),
            title: Text('상품 등록 현황'),
            trailing: Icon(Icons.navigate_next, color: Colors.black),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.note_alt_outlined, color: Colors.black),
            title: Text('주문 관리'),
            trailing: Icon(Icons.navigate_next, color: Colors.black),
          ),
          Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.comment_outlined, color: Colors.black),
            title: Text('후기 관리'),
            trailing: Icon(Icons.navigate_next, color: Colors.black),
          ),
          Divider(),
          ListTile(
            onTap: () {
              Get.to(QnaManagementPage());
            },
            leading: Icon(Icons.quiz_outlined, color: Colors.black),
            title: Text('문의 관리'),
            trailing: Icon(Icons.navigate_next, color: Colors.black),
          ),
          Divider(),

        ],
      ),
    );
  }
}
