import 'package:buy_idea/component/account/select_sign_up_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectSignUpPage extends StatelessWidget{
  const SelectSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectSignUpForm()
          ],
        ),
      ),
    );
  }
}