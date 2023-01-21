import 'package:flutter/material.dart';

class ReviewRegisterTextFieldForm extends StatefulWidget {
  final String nickname;
  final TextEditingController contentController;
  const ReviewRegisterTextFieldForm({
    Key? key,
    required this.nickname,
    required this.contentController
  }) : super(key: key);

  @override
  State<ReviewRegisterTextFieldForm> createState() => _ReviewRegisterTextFieldFormState();
}

class _ReviewRegisterTextFieldFormState extends State<ReviewRegisterTextFieldForm> {
  final int maxLength = 500;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(height: 15, color: Colors.grey, thickness: 1),
          Row(
            children: [
              SizedBox(
                width: 70,
                child: Text(
                  '닉네임',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                  textAlign: TextAlign.center,
                )
              ),
              Expanded(
                child: Text(
                  widget.nickname,
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.center,
                )
              )
            ],
          ),
          Divider(height: 15, color: Colors.grey, thickness: 1),
          SizedBox(height: 10),
          TextFormField(
            maxLines: 15,
            maxLength: maxLength,
            controller: widget.contentController,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 2.0)
              ),
              label: Icon(Icons.edit),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: '구매 후기 내용을 작성해주세요...',
              hintStyle: TextStyle(fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
