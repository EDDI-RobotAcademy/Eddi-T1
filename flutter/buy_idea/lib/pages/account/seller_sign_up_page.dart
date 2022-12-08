import 'package:flutter/material.dart';

import '../../component/account/sign_up/sign_up_form.dart';

class SellerSignUpPage extends StatefulWidget {
  const SellerSignUpPage({Key? key}) : super(key: key);

  @override
  State<SellerSignUpPage> createState() => _SellerSignUpPage();
}

class _SellerSignUpPage extends State<SellerSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff2F4F4F)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("판매자 회원가입", style: TextStyle(fontSize: 30)),
                const SizedBox(height: 80),
                SignUpForm(textFieldName: "상호명", memberType: "판매자")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
