import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

class DeliveryAddressInputForm extends StatefulWidget {
  final TextEditingController recipientController;
  final TextEditingController phoneController;
  final TextEditingController zipcodeController;
  final TextEditingController cityController;
  final TextEditingController streetController;
  final TextEditingController addressDetailController;

  const DeliveryAddressInputForm({
    Key? key,
    required this.recipientController,
    required this.phoneController,
    required this.zipcodeController,
    required this.cityController,
    required this.streetController,
    required this.addressDetailController
  }) : super(key: key);

  @override
  State<DeliveryAddressInputForm> createState() => _DeliveryAddressInputFormState();
}

class _DeliveryAddressInputFormState extends State<DeliveryAddressInputForm> {

  bool _checkEnterAddress() {
    if (widget.zipcodeController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('배송지', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Divider(height: 20, color: Colors.grey, thickness: 1,),
          Row(
            children: [
              SizedBox(
                width: 70,
                  child: Text('받는분', style: TextStyle(fontSize: 13, color: Colors.grey))
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(fontSize: 12),
                  controller: widget.recipientController,
                  decoration: InputDecoration(
                      hintText: '이름을 입력하세요.',
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      isDense: true,
                      border: InputBorder.none
                  ),
                ),
              )
            ],
          ),
          Divider(height: 20, color: Colors.grey, thickness: 1,),
          Row(
            children: [
              SizedBox(
                width: 70,
                  child: Text('전화번호', style: TextStyle(fontSize: 13, color: Colors.grey))
              ),
              Expanded(
                child: TextFormField(
                  style: TextStyle(fontSize: 12),
                  controller: widget.phoneController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintText: '전화번호를 입력하세요.',
                      hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                      isDense: true,
                      border: InputBorder.none
                  ),
                ),
              )
            ],
          ),
          Divider(height: 20, color: Colors.grey, thickness: 1,),
          Row(
            children: [
              SizedBox(
                  width: 70,
                  height: 130,
                  child: Text('주소', style: TextStyle(fontSize: 13, color: Colors.grey))
              ),
              _checkEnterAddress()
                  ? Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _addressAPI();
                        },
                        child: SizedBox(
                            height: 130,
                            child: Text('주소를 입력하세요.', style: TextStyle(fontSize: 12, color: Colors.grey))
                        ),
                      )
                    )
                  : Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _addressAPI();
                      },
                      child: SizedBox(
                        height: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              style: TextStyle(fontSize: 12),
                              enabled: false,
                              controller: widget.zipcodeController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(fontSize: 12),
                              enabled: false,
                              controller: widget.cityController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(fontSize: 12),
                              enabled: false,
                              controller: widget.streetController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none
                              ),
                            ),
                            TextFormField(
                              style: TextStyle(fontSize: 12),
                              controller: widget.addressDetailController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  hintText: '상세주소를 입력하세요.',
                                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                                  isDense: true,
                                  border: InputBorder.none
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ),
            ],
          )
        ],
      ),
    );
  }

  _addressAPI() async {
    KopoModel model = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RemediKopo(),
      ),
    );
    setState(() {
      widget.zipcodeController.text = model.zonecode!;
      widget.cityController.text = model.sido!;
      widget.streetController.text = model.roadAddress!;
    });
  }
}
