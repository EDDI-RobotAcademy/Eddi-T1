import 'package:buy_idea/component/common/account/sign_up_id_text_form.dart';
import 'package:buy_idea/component/common/account/sign_up_nickname_text_form.dart';
import 'package:buy_idea/component/common/account/sign_up_password_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpFormField extends StatefulWidget {
  SignUpFormField({Key? key}) : super(key: key);

  @override
  State<SignUpFormField> createState() => _SignUpFormFieldState();

}

class _SignUpFormFieldState extends State<SignUpFormField> {

  final _formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nicknameController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SignUpIdTextForm(controller: idController),
            SizedBox(height: 30),
            SignUpPasswordTextForm(controller: passwordController, confirmController: confirmPasswordController),
            SizedBox(height: 30),
            SignUpNicknameTextForm(controller: nicknameController, textFieldName: "닉네임"),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(250, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                primary: Color(0xFF2F4F4F)
              ),
                onPressed: (){
                if(_formKey.currentState!.validate()){
                  if(SignUpIdTextForm.buttonStateValue == true && SignUpNicknameTextForm.buttonStateValue == true){
                    var validation = null;
                    // MemberSpringApi().singUp(UserSingUpRequest(
                    //     idController.text,
                    //     confirmPasswordController.text,
                    //     nicknameController.text));
                    validation.then((value){
                      if(value.success == true) {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const SelectSignInPage()));
                      }
                    });
                  }
                }
                }, child: Text("확인", style: TextStyle(color: Colors.black)),
            )
          ],
        ));
  }
}