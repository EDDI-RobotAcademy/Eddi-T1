import 'package:buy_idea/pages/seller/seller_main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remedi_kopo/remedi_kopo.dart';

import '../../../api/seller/spring_seller_info_api.dart';
import '../../../pages/seller/my_info/seller_my_info_page.dart';
import '../../common/common_alert_dialog.dart';
import 'business_info_register_text_field.dart';

class BusinessInfoRegisterForm extends StatefulWidget {
  const BusinessInfoRegisterForm({Key? key}) : super(key: key);

  @override
  State<BusinessInfoRegisterForm> createState() =>
      _BusinessInfoRegisterFormState();
}

class _BusinessInfoRegisterFormState extends State<BusinessInfoRegisterForm> {
  final realNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final zipcodeController = TextEditingController();
  final cityController = TextEditingController();
  final streetController = TextEditingController();
  final addressDetailController = TextEditingController();

  bool _checkEnterAddress() {
    if (zipcodeController.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  sellerInfoRegisterAction() async {
    await SpringSellerInfoApi().sellerProfileRegister(SellerProfileRequest(
        SellerMainPage.sellerNickname,
        realNameController.text,
        phoneNumberController.text,
        registrationNumberController.text,
        CompanyInfoRequest(zipcodeController.text, cityController.text,
            streetController.text, addressDetailController.text)));

    if (SpringSellerInfoApi.sellerInfoRegisterResponse.statusCode == 200) {
      _registersuccessShowDialog();
      debugPrint("통신 성공");
    } else {
      _registerFailShowDialog();
      debugPrint("통신 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 60.0),
          Image.asset("assets/seller_register.png", height: 100),
          SizedBox(height: 10.0),
          Text('업체 정보 입력',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 40.0),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                SizedBox(width: 100.0, child: Text('대표명')),
                SizedBox(width: 10.0),
                Container(
                    width: 250.0,
                    height: 30.0,
                    child: BusinessInfoRegisterTextField(
                        hintText: '대표 성명 입력', controller: realNameController)),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                SizedBox(width: 100.0, child: Text('업체 전화번호')),
                SizedBox(width: 10.0),
                Container(
                    width: 250.0,
                    height: 30.0,
                    child: BusinessInfoRegisterTextField(
                        hintText: '업체 전화번호 입력',
                        controller: phoneNumberController)),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                SizedBox(width: 100.0, child: Text('사업자 등록번호')),
                SizedBox(width: 10.0),
                Container(
                    width: 250.0,
                    height: 30.0,
                    child: BusinessInfoRegisterTextField(
                        hintText: '사업자 등록번호 입력',
                        controller: registrationNumberController)),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Container(
                      alignment: Alignment.topLeft,
                      width: 100.0,
                      height: 200,
                      child: Text('업체 주소')),
                  SizedBox(width: 10.0),
                  _checkEnterAddress()
                      ? GestureDetector(
                          onTap: () {
                            _addressAPI();
                          },
                          child: Container(
                              height: 200,
                              width: 250.0,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(4.0)),
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text('주소를 입력하세요.',
                                    style: TextStyle(color: Colors.grey)),
                              )),
                        )
                      : GestureDetector(
                          onTap: () {
                            _addressAPI();
                          },
                          child: Container(
                            height: 200,
                            width: 250.0,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4.0)),
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextFormField(
                                    style: TextStyle(fontSize: 14),
                                    enabled: false,
                                    controller: zipcodeController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none),
                                  ),
                                  TextFormField(
                                    style: TextStyle(fontSize: 14),
                                    enabled: false,
                                    controller: cityController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none),
                                  ),
                                  TextFormField(
                                    style: TextStyle(fontSize: 14),
                                    enabled: false,
                                    controller: streetController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                        isDense: true,
                                        border: InputBorder.none),
                                  ),
                                  Container(
                                    height: 30.0,
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 14),
                                      controller: addressDetailController,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          hintText: '상세주소를 입력하세요.',
                                          hintStyle: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                          isDense: true,
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              )),
          SizedBox(height: 30.0),
          TextButton(
              onPressed: () {
                if (realNameController.text.isNotEmpty &&
                    phoneNumberController.text.isNotEmpty &&
                    registrationNumberController.text.isNotEmpty &&
                    zipcodeController.text.isNotEmpty &&
                    cityController.text.isNotEmpty &&
                    streetController.text.isNotEmpty &&
                    addressDetailController.text.isNotEmpty) {
                  /// 등록 요청 AP
                  sellerInfoRegisterAction();
                } else {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.white.withOpacity(0.7),
                          title: Text('⚠️'),
                          content: Text('입력사항들을 전부 기입해주세요.',
                              textAlign: TextAlign.center),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('OK'))
                          ],
                        );
                      });
                }
              },
              child: Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Color(0xFF2F4F4F),
                  ),
                  child: Center(
                      child: Text('등록하기',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold))))),
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
      zipcodeController.text = model.zonecode!;
      cityController.text = model.sido!;
      streetController.text = model.roadAddress!;
    });
  }

  void _registersuccessShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
              title: "🙆‍♀️",
              content: '등록되었습니다.',
              onCustomButtonPressed: () {
                Get.back();
                Get.offAll(SellerMyInfoPage());
              });
        });
  }

  void _registerFailShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
              title: "⚠️",
              content: '죄송합니다. \n서버가 불안정하여 삭제가 실패했습니다.',
              onCustomButtonPressed: () {
                Get.back();
              });
        });
  }
}
