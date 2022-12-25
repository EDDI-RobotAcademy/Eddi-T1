import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../api/spring_member_api.dart';
import '../../../../pages/buyer/my_info/my_info_page.dart';
import '../../../account/member.dart';
import '../../../account/sign_up/sign_up_nickname_text_form.dart';
import '../../../common/common_alert_dialog.dart';

class NicknameModifyForm extends StatefulWidget {
  const NicknameModifyForm({Key? key}) : super(key: key);

  @override
  State<NicknameModifyForm> createState() => _NicknameModifyFormState();
}

class _NicknameModifyFormState extends State<NicknameModifyForm> {
  final _formKey = GlobalKey<FormState>();
  final nicknameController = TextEditingController();
  static const storage = FlutterSecureStorage();

  @override
  void dispose() {
    nicknameController.dispose();
    super.dispose();
  }

  memberNicknameModifyAction() async {
    dynamic memberNickname = await (storage.read(key: 'nickname'));

    await SpringMemberApi().memberNicknameModify(
        MemberNicknameModifyRequest(nicknameController.text, memberNickname));

    if (SpringMemberApi.memberNicknameModifyResponse.statusCode == 200) {
      debugPrint('statusCode 200!');

      var val = jsonDecode(
          utf8.decode(SpringMemberApi.memberNicknameModifyResponse.bodyBytes));
      var account = MemberNickname.fromJson(val);
      await storage.write(key: 'nickname', value: account.nickname);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CommonAlertDialog(
                title: "✅",
                content: '수정되었습니다.',
                onCustomButtonPressed: () {
                  Get.off(const MyInfoPage());
                });
          });
      debugPrint('수정 성공!');
    } else {
      debugPrint('수정 실패');
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CommonAlertDialog(
                title: "⚠️",
                content: '죄송합니다. \n닉네임 수정이 실패했습니다.',
                onCustomButtonPressed: () {
                  Get.back();
                });
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 280.0, top: 10.0, bottom: 10.0),
              child: Text(
                '닉네임 변경',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SignUpNicknameTextForm(
                  textFieldName: '닉네임', controller: nicknameController),
            ),
            const SizedBox(height: 5.0),
            TextButton(
              child:
                  const Text("닉네임 변경", style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                minimumSize: const Size(250, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: const Color(0xff2F4F4F),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (SignUpNicknameTextForm.buttonStateValue == true) {
                    //Spring API 수정 요청
                    memberNicknameModifyAction();
                  } else {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return CommonAlertDialog(
                              title: "⚠️",
                              content: "중복체크를 확인해주세요.",
                              onCustomButtonPressed: () {
                                Get.back();
                              });
                        });
                  }
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
