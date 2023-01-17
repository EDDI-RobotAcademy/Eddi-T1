import 'package:flutter/material.dart';

class BusinessInfoRegisterTextField extends StatefulWidget {
  const BusinessInfoRegisterTextField(
      {Key? key, this.controller, required this.hintText})
      : super(key: key);
  final controller;
  final String hintText;

  @override
  State<BusinessInfoRegisterTextField> createState() =>
      _BusinessInfoRegisterTextFieldState();
}

class _BusinessInfoRegisterTextFieldState
    extends State<BusinessInfoRegisterTextField> {
  String textValue = '';

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 1,
      textAlign: TextAlign.start,
      onChanged: (value) {
        setState(() {
          textValue = value;
        });
      },
      controller: widget.controller,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(5.0),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0)),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
      ),
    );
  }
}
