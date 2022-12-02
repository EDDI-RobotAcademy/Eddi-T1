import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/size.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({Key? key,  required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        const SizedBox(height: small_gap,),
        TextFormField(
          //유효성 체크 공백일 경우 메시지
          validator: (value) => value!.isEmpty ? "필수항목입니다" : null,
          //마킹 패스워드일 경우 true
          obscureText: text == "Password" ? true : false,
          //데코레이션 힌트문자나 데코기능 추가
          decoration: InputDecoration(
            hintText: "$text", //힌트 문자
            enabledBorder: //기본 모양
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder: //포커스 모양
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            errorBorder: //에러 모양
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedErrorBorder: //에러후포커스 모양
            OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          ),
        )
      ],
    );
  }
}
