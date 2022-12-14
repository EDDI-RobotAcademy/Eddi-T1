import 'package:buy_idea/component/account/text_form_field.dart';
import 'package:buy_idea/component/account/toggle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/size.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late List<bool> isSelected;

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  final memberIdController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [

            const SizedBox(height: large_gap),
            Center(
              child: ToggleButtons(
                borderColor: Colors.blueGrey,
                fillColor: Color(0xFF2F4F4F),
                borderWidth: 1,
                selectedBorderColor: Colors.black,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '일반회원로그인',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      ' 판매자로그인 ',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                    debugPrint(isSelected[0].toString());
                  });
                },
                isSelected: isSelected,
              ),
            ),
            const SizedBox(height: large_gap),
            CustomTextFormField(controller: memberIdController, text: "아이디"),
            const SizedBox(height: large_gap),
            CustomTextFormField(controller: passwordController, text: "비밀번호",),
            const SizedBox(height: large_gap),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    /*Navigator.push(context, MaterialPageRoute(builder: (context) => home()));*/
                  }
                  // SpringMemberApi().login(UserLoginRequest(memberIdController.text, passwordController.text));
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
