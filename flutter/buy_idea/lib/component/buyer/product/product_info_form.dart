import 'package:flutter/material.dart';

class ProductInfoForm extends StatefulWidget {
  final String content;

  const ProductInfoForm({
    Key? key,
    required this.content
  }) : super(key: key);

  @override
  State<ProductInfoForm> createState() => _ProductInfoFormState();
}

class _ProductInfoFormState extends State<ProductInfoForm> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
        color: Colors.white,
        child: Text(widget.content, style: TextStyle(fontSize: 15), textAlign: TextAlign.center,),
      ),
    );
  }
}
