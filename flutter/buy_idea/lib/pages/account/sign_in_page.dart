import 'package:buy_idea/component/account/sign_in_form.dart';
import 'package:buy_idea/pages/account/select_sign_up_page.dart';
import 'package:flutter/material.dart';

import '../../component/common/logo.dart';
import '../../utility/size.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

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
            const SizedBox(height: large_gap,),
            const Logo(),
            const SizedBox(height: large_gap,),
            SignInForm(),
            Divider(height: 40, thickness: 1),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectSignUpPage()));
                },
                child: const Text(
                  "Create account",
                  style: TextStyle(
                    color: Color(0xFF2F4F4F), fontWeight: FontWeight.bold)
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
