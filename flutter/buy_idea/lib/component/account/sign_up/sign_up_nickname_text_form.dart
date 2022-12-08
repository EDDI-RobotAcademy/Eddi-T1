import 'package:buy_idea/api/spring_member_api.dart';
import 'package:buy_idea/utility/validation.dart';
import 'package:flutter/material.dart';

class SignUpNicknameTextForm extends StatefulWidget{
  SignUpNicknameTextForm({Key? key, this.controller, required this.textFieldName}) : super(key: key);

  final controller;
  final String textFieldName;
  static bool? buttonStateValue;

  @override
  State<SignUpNicknameTextForm> createState() => _SignUpNicknameTextFormState();
}

class _SignUpNicknameTextFormState extends State<SignUpNicknameTextForm> {
  String? nickName;
  bool buttonEnable = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.emailAddress,
      validator: (text) => Validation().validateNickname(text!),
      onChanged: (text){
        setState(() {
          nickName = text;
          if (Validation().validateNickname(text) == null){
            buttonEnable = true;
            SignUpNicknameTextForm.buttonStateValue = false;
          }
          if(Validation().validateNickname(text) != null){
            buttonEnable = false;
          }
        });
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: widget.textFieldName,
        hintText: widget.textFieldName + "을 입력해주세요",
        prefixIcon: Icon(Icons.portrait),
        suffixIcon: Container(
          margin: EdgeInsets.only(right: 10),
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Color(0XFF2F4F4F),
                primary: Colors.white,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
            ),
            onPressed: buttonEnable
                ? () {
              var validation = SpringMemberApi().nickNameDuplicateCheck(
                DuplicateNicknameRequest(nickName!)
              );


              validation.then((value){
                if(value.success == true){
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context){
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          content: Text(
                            "사용 가능한 " + widget.textFieldName +"입니다.",
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("확인", style: TextStyle(color: Colors.black)),
                            )
                          ],
                        );
                      });
                  setState(() {
                    buttonEnable = false;
                    SignUpNicknameTextForm.buttonStateValue = true;
                  });
                }
                if(value.success == false){
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          content: Text(
                            "중복된 " + widget.textFieldName +"입니다.",
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text("확인", style: TextStyle(color: Colors.black)),
                            )
                          ],
                        );
                      });
                }
              });
            }
            :null,
            child: Text("중복 확인", style: TextStyle(color: Color(0xffFAEBD7))),
          ),
        ),
        border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
    );
  }
}