import 'package:buy_idea/pages/seller/my_info/business_info_regiser_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusinessInfoRegisterButton extends StatefulWidget {
  const BusinessInfoRegisterButton({Key? key, required this.infoCheck})
      : super(key: key);
  final bool infoCheck;

  @override
  State<BusinessInfoRegisterButton> createState() =>
      _BusinessInfoRegisterButtonState();
}

class _BusinessInfoRegisterButtonState
    extends State<BusinessInfoRegisterButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.infoCheck == true) {
      /// 판매자 정보가 있을 때
      return TextButton(
          onPressed: () {},
          child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Colors.grey,
              ),
              child: Center(
                  child: Text('정보 등록',
                      style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFFf5f5f5),
                          fontWeight: FontWeight.bold)))));
    } else {
      return TextButton(
          onPressed: () {
            /// 등록 페이지 연결
            Get.to(BusinessInfoRegisterPage());
          },
          child: Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xFF2F4F4F),
              ),
              child: Center(
                  child: Text('정보 등록',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)))));
    }
  }
}
