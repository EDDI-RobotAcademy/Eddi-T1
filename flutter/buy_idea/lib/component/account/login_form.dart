import 'package:buy_idea/component/account/text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/size.dart';

class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: xmedium_gap),
            const CustomTextFormField(text: "아이디"),
            const SizedBox(height: large_gap),
            const CustomTextFormField(text: "비밀번호"),
            const SizedBox(height: large_gap),
        ElevatedButton(
          onPressed: () {
            //유효성 검사
            if (_formKey.currentState!.validate()) {
              Navigator.pushNamed(context, "/home");
            }
          },
          child: const Text("LOGIN"),
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF2F4F4F),
            minimumSize: Size(400,50),
            padding: EdgeInsets.all(10.0),
            textStyle: TextStyle(color: Colors.white)
          )
        )
          ],
        )
    );
  }
}
