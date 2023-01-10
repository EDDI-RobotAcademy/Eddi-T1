import 'package:buy_idea/component/buyer/my_info/my_order_info/QnA/question_register_bottom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:switcher_button/switcher_button.dart';

import '../../../../../pages/buyer/product/product_details_page.dart';

class QuestionRegisterForm extends StatefulWidget {
  const QuestionRegisterForm(
      {Key? key,
      required this.productNo,
      required this.productImage,
      required this.productTitle})
      : super(key: key);
  final int productNo;
  final String productImage;
  final String productTitle;

  @override
  State<QuestionRegisterForm> createState() => _QuestionRegisterFormState();
}

class _QuestionRegisterFormState extends State<QuestionRegisterForm> {
  List<String> dropdownList = ['상품문의', '배송문의', '환불/취소 문의', '교환문의', '기타'];
  String selectedDropdown = '상품문의';
  TextEditingController _contentController = TextEditingController();
  String textValue = "";
  bool lockButton = true;
  final int maxLength = 500;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () {
                Get.to(ProductDetailsPage(productNo: widget.productNo));
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/product/${widget.productImage}'))),
              ),
            ),
            SizedBox(width: 10.0),
            Column(
              children: [
                Container(
                  width: 250.0,
                  child: Text('• 문의할 상품',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                SizedBox(height: 10.0),
                Container(
                  width: 250.0,
                  child: Text(widget.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 40.0),
        Container(
          width: 300.0,
          child: DropdownButton(
            value: selectedDropdown,
            isExpanded: true,
            items: dropdownList.map((String item) {
              return DropdownMenuItem<String>(
                child: Text(
                  '$item',
                  style: const TextStyle(fontSize: 14),
                ),
                value: item,
              );
            }).toList(),
            borderRadius: BorderRadius.circular(10),
            onChanged: (dynamic value) {
              setState(() {
                selectedDropdown = value;
              });
            },
          ),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          maxLines: 15,
          maxLength: maxLength,
          onChanged: (value) {
            setState(() {
              textValue = value;
            });
          },
          controller: _contentController,
          style: TextStyle(fontSize: 13),
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0)),
            label: Icon(Icons.edit),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: '문의 내용을 작성해주세요...',
            hintStyle: TextStyle(fontSize: 13),
          ),
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            SwitcherButton(
              value: true,
              size: 40.0,
              offColor: Color(0xFFf2f2f2),
              onColor: Color(0xFF2F4F4F),
              onChange: (value){
                lockButton = value;
              },
            ),
            SizedBox(width: 10.0),
            Text('비밀글로 작성하기', style: TextStyle(fontSize: 14))
          ],
        ),
        SizedBox(height: 60.0),
        QuestionRegisterBottomButton(contentController: _contentController),
      ],
    );
  }
}
