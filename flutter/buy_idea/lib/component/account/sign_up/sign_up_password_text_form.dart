import 'package:buy_idea/utility/validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpPasswordTextForm extends StatefulWidget{
  const SignUpPasswordTextForm({Key? key, this.controller, this.confirmController}) : super(key: key);

  final controller;
  final confirmController;

  @override
  State<SignUpPasswordTextForm> createState() => _SignUpPasswordTextFormState();
}

class _SignUpPasswordTextFormState extends State<SignUpPasswordTextForm>{


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          validator: (text) => Validation().validatePassword(text!),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "비밀번호",
            hintText: "8~16자 이내(영문,숫자.특수문자 필수)",
            prefixIcon: Icon(Icons.key),
            enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedErrorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          controller: widget.confirmController,
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          validator: (text){
            if(text!.isEmpty){
              return "비밀번호를 다시 입력해주세요.";
            }else if(text != widget.controller.text){
              return "비밀번호가 일지하지 않습니다.";
            }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: "비밀번호 확인",
            hintText: "다시한번 입력해주세요",
            prefixIcon: Icon(Icons.key),
            enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            errorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedErrorBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        )
      ],
    );
  }
}