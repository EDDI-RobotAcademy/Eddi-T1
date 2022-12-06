import 'package:buy_idea/component/common/account/sign_up_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SellerSignUpPage extends StatefulWidget{
  const SellerSignUpPage({Key? key}) : super(key: key);

  @override
  State<SellerSignUpPage> createState() => _SellerSignUpPage();
}

class _SellerSignUpPage extends State<SellerSignUpPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 70, 30, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("판매자 회원가입", style: TextStyle(fontSize: 40)),
                SizedBox(height: 80),
                SignUpFormField(textFieldName: "업체명")
              ],
            ),
          ),
        ),
      ),
    );
  }
}