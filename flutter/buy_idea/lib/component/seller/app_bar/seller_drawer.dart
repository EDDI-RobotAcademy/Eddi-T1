import 'package:buy_idea/pages/seller/product_registration_status/product_registration_status_page.dart';
import 'package:buy_idea/pages/seller/qna_management/qna_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../pages/intro_screen_page.dart';
import '../../../pages/seller/my_info/seller_my_info_page.dart';
import '../../../pages/seller/order_management/order_management_page.dart';
import '../../../pages/seller/seller_main_page.dart';
import '../../common/yes_or_no_alert_dialog.dart';

class SellerDrawer extends StatefulWidget {
  const SellerDrawer({Key? key, required this.nickname}) : super(key: key);

  final String nickname;

  @override
  State<SellerDrawer> createState() => _SellerDrawerState();
}

class _SellerDrawerState extends State<SellerDrawer> {
  static const storage = FlutterSecureStorage();

  _logout() async {
    await storage.delete(key: 'userToken');
    await storage.delete(key: 'memberId');
    await storage.delete(key: 'nickname');
    await storage.delete(key: 'memberType');
    Get.offAll(IntroScreenPage());
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  height: 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '환영합니다!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                AssetImage('assets/default_profile_image.png'),
                            backgroundColor: Colors.white,
                          ),
                      SizedBox(width: 15.0),
                      Column(
                        children: [
                      SizedBox(height: 10.0),
                      Row(
                          children: [
                            Text(
                              '💡 ${widget.nickname}',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              '의',
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      Text(
                        '아이디어 저장소입니다.',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                        ],
                      ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xff2F4F4F),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                ),
                SizedBox(height: 15),
                ListTile(
                  onTap: () {
                    Get.to(SellerMainPage());
                  },
                  leading:
                      Icon(Icons.house_siding_outlined, color: Colors.black),
                  title: Text('Home'),
                  trailing: Icon(Icons.navigate_next, color: Colors.black),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Get.to(SellerMyInfoPage());
                  },
                  leading:
                      Icon(Icons.account_box_outlined, color: Colors.black),
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
                  onTap: () {
                    Get.to(OrderManagementPage());
                  },
                  leading: Icon(Icons.note_alt_outlined, color: Colors.black),
                  title: Text('주문 현황'),
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
          ),
          Divider(),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return YesOrNoAlertDialog(
                        title: '🔑',
                        content: '로그아웃 하시겠습니까?',
                        yesButtonPressed: () {
                          Get.back();
                          _logout();
                        },
                        noButtonPressed: () {
                          Get.back();
                        },
                      );
                    });
              },
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('로그아웃'),
              trailing: Icon(Icons.navigate_next, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
