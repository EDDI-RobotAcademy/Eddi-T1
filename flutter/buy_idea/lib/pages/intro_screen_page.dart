import 'dart:async';

import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:buy_idea/pages/seller/seller_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class IntroScreenPage extends StatefulWidget {
  const IntroScreenPage({Key? key}) : super(key: key);

  @override
  State<IntroScreenPage> createState() => _IntroScreenPageState();
}

class _IntroScreenPageState extends State<IntroScreenPage> {

  static const storage = FlutterSecureStorage();
  dynamic memberType = '';

  _asyncMethod() async {
    memberType = await storage.read(key: 'memberType');
    setState(() {
      memberType;
    });
    if (memberType == '일반회원') {
      debugPrint('일반회원 타입');
      Get.offAll(const MainPage());
    } else if (memberType == '판매자') {
      debugPrint('판매자 타입');
      Get.offAll(const SellerMainPage());
    } else {
      debugPrint('그 외');
      Get.offAll(const MainPage());
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      _asyncMethod();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage('assets/buydia_animation_logo.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
