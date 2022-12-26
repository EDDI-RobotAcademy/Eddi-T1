
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../account/sign_up/sign_up_password_text_form.dart';

class PasswordModifyForm extends StatefulWidget {
  const PasswordModifyForm({Key? key}) : super(key: key);

  @override
  State<PasswordModifyForm> createState() => _PasswordModifyFormState();
}

class _PasswordModifyFormState extends State<PasswordModifyForm> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  static const storage = FlutterSecureStorage();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  memberPasswordModifyAction() async {

  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 270.0, top: 10.0, bottom: 10.0),
              child: Text(
                '비밀번호 변경',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 300.0, top: 3.0, bottom: 3.0),
                child: Text(
                  '새 비밀번호',
                  style: TextStyle(fontSize: 14),
                )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SignUpPasswordTextForm(controller: passwordController, confirmController: confirmPasswordController),
            ),
            const SizedBox(height: 5.0),
            TextButton(
              child:
                  const Text("비밀번호 변경", style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                minimumSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: const Color(0xff2F4F4F),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                    //Spring API 수정 요청
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
