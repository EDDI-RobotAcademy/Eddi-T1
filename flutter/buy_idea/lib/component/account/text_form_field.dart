import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/size.dart';
import '../../utility/validation.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({Key? key, required this.text, required this.controller}) : super(key: key);

  final String text;
  final controller;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}


class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.text),
        const SizedBox(height: small_gap,),
        TextFormField(
          controller: widget.controller,

          validator: (value) {
            if (widget.text == "아이디") {
              return Validation().validateId(value!);
            } else if (widget.text == "비밀번호") {
              return Validation().validatePassword(value!);
            }
            },

          autovalidateMode: AutovalidateMode.onUserInteraction,

          obscureText: widget.text == "Password" ? true : false,


            //validation 아이디
          decoration: InputDecoration(
            hintText: "${widget.text}", //.하고 할땐 {} 감싸줘야함!!! $는 하나만 인식함
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
