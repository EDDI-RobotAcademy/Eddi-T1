import 'package:buy_idea/api/spring_member_api.dart';
import 'package:buy_idea/utility/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpIdTextForm extends StatefulWidget {
  SignUpIdTextForm({Key? key, this.controller}) : super(key: key);

  final controller;
  static bool? buttonStateValue;

  @override
  State<SignUpIdTextForm> createState() => _SignUpIdTextFormState();
}

class _SignUpIdTextFormState extends State<SignUpIdTextForm> {
  String? memberId;
  bool buttonEnable = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      validator: (text) => Validation().validateId(text!),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (text) {
        setState(() {
          memberId = text;
          if (Validation().validateId(memberId!) == null) {
            buttonEnable = true;
            SignUpIdTextForm.buttonStateValue = false;
          }
          if (Validation().validateId(memberId!) != null) {
            buttonEnable = false;
          }
        });
      },
      decoration: InputDecoration(
          labelText: "아이디",
          hintText: "아이디를 입력해주세요",
          enabledBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          errorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          focusedErrorBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.account_circle),
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
                      var validation = SpringMemberApi().memberIdDuplicateCheck(
                          DuplicateMemberIdRequest(memberId!));

                      validation.then((value) {
                        if (value.success == true) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Text(
                                    "사용 가능한 아이디입니다.",
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("확인",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ],
                                );
                              });
                          setState(() {
                            buttonEnable = false;
                            SignUpIdTextForm.buttonStateValue = true;
                          });
                        }
                        if (value.success == false) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Text(
                                    "중복된 아이디 입니다.",
                                    textAlign: TextAlign.center,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("확인",
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ],
                                );
                              });
                        }
                      });
                    }
                  : null,
              child: Text("중복 확인",
                style: TextStyle(color: Color(0xffFAEBD7))),
            ),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
    );
  }
}
