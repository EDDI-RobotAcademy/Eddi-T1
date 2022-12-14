import 'package:buy_idea/component/account/select_sign_up_form.dart';
import 'package:buy_idea/component/common/logo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/size.dart';

class SelectSignUpPage extends StatelessWidget{
  const SelectSignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Color(0xff2F4F4F)
        ),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SizedBox(height: 200),
            Logo(),
            SizedBox(width: large_gap, height: 90.0),
            SelectSignUpForm(),
          ],
        ),
      ),
    );
  }
}