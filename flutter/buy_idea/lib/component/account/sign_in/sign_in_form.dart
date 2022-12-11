import 'dart:convert';

import 'package:buy_idea/api/spring_member_api.dart';
import 'package:buy_idea/component/account/sign_in/sign_in_text_form.dart';
import 'package:buy_idea/pages/seller/seller_main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../pages/main_page.dart';
import '../../../utility/size.dart';
import '../../common/common_alert_dialog.dart';
import '../Member.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late List<bool> isSelected;
  static const storage = FlutterSecureStorage();
  dynamic memberInfo = '';
  dynamic memberType = '';

  final _formKey = GlobalKey<FormState>();
  final memberIdController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    memberInfo = await storage.read(key: 'userToken');
    memberType = await storage.read(key: 'memberType');

    if (memberInfo != null) {
      debugPrint(memberInfo);
      debugPrint(memberType);
      if (memberType == '일반회원') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
      } else if (memberType == '판매자') {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerMainPage()));
      }
    } else {
      debugPrint('로그인이 필요합니다');
    }
  }

  signInAction() async {
    if (isSelected[0] == true) {
      await SpringMemberApi().signInApi(MemberSignInRequest(
          memberIdController.text, passwordController.text, "일반회원"));
    } else if (isSelected[0] == false) {
      await SpringMemberApi().signInApi(MemberSignInRequest(
          memberIdController.text, passwordController.text, "판매자"));
    }

    if (SpringMemberApi.signInResponse.statusCode == 200) {
      debugPrint('통신 성공!');
      var val = jsonDecode(utf8.decode(SpringMemberApi.signInResponse.bodyBytes));
      var account = Member.fromJson(val);

      await storage.write(key: 'userToken', value: account.userToken);
      await storage.write(key: 'memberId', value: account.memberId);
      await storage.write(key: 'nickname', value: account.nickname);
      await storage.write(key: 'memberType', value: account.memberType);

      _signInSuccessShowDialog();
      debugPrint('접속 성공!');
    } else {
      _signInFailShowDialog();
      debugPrint('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: large_gap),
            Center(
              child: ToggleButtons(
                borderColor: Colors.blueGrey,
                fillColor: Color(0xFF2F4F4F),
                borderWidth: 1,
                selectedBorderColor: Colors.black,
                selectedColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      '일반회원 로그인',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      ' 판매자 로그인 ',
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < isSelected.length; i++) {
                      isSelected[i] = i == index;
                    }
                    debugPrint(isSelected[0].toString());
                  });
                },
                isSelected: isSelected,
              ),
            ),
            const SizedBox(height: large_gap),
            SignInTextForm(controller: memberIdController, text: "아이디"),
            const SizedBox(height: large_gap),
            SignInTextForm(
              controller: passwordController,
              text: "비밀번호",
            ),
            const SizedBox(height: large_gap),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    signInAction();
                  }
                },
                child: const Text("LOGIN"),
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFF2F4F4F),
                    minimumSize: Size(400, 50),
                    padding: EdgeInsets.all(10.0),
                    textStyle: TextStyle(color: Colors.white)))
          ],
        ));
  }

  /// 로그인 성공 alertDialog
  void _signInSuccessShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
              title: "🎉️",
              content: '환영합니다🥰 \n 홈으로 이동합니다.',
              onCustomButtonPressed: () {
                if (isSelected[0] == true) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MainPage()));
                } else if (isSelected[0] == false) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SellerMainPage()));
                }

              });
        });
  }

  /// 로그인 실패 alertDialog
  void _signInFailShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
            title: "⚠️",
            content: '이메일 혹은 패스워드가 잘 못 되었습니다.',
            onCustomButtonPressed: () {
              Navigator.of(context).pop();
            },
          );
        });
  }
}
