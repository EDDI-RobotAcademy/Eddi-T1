import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectSignUpButton extends StatelessWidget {
  SelectSignUpButton({Key? key, required this.buttonName}) : super(key: key);

  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
      TextButton(
          onPressed: () {
            if (buttonName == "판매자 회원가입") {
              Navigator.pushNamed(context, "/sellerSingUp");
            } else {
              Navigator.pushNamed(context, "/consumerSingUp");
            }
          },
          child: Text(buttonName))
    ]);
  }
}
