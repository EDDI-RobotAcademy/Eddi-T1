import 'package:buy_idea/pages/account/seller_sign_up_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/account/buyer_sign_up_page.dart';

class SelectSignUpButton extends StatelessWidget {
  SelectSignUpButton({Key? key, required this.buttonName}) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color(0XFF2F4F4F),
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: Size(140, 130)
        ),
          onPressed: () {
            if (buttonName == "판매자 회원가입") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerSignUpPage()));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerSignUpPage()));
            }
          },
          child: Text(buttonName,
            style: TextStyle(color: Color(0xFFFAEBD7)),))
    ]);
  }
}
