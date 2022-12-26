import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/title_top_bar.dart';
import '../../../component/buyer/my_info/my_info_modify/my_profile_form.dart';
import '../../../component/buyer/my_info/my_info_modify/nickname_modify_form.dart';
import '../../../component/buyer/my_info/my_info_modify/password_modify_form.dart';

class MyInfoModifyPage extends StatefulWidget {
  const MyInfoModifyPage({Key? key}) : super(key: key);

  @override
  State<MyInfoModifyPage> createState() => _MyInfoModifyPageState();
}

class _MyInfoModifyPageState extends State<MyInfoModifyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const TitleTopBar(titleText: '내 정보 수정'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey,
                child: Column(
                  children: const [
                    MyProfileForm(),
                    SizedBox(height: 1),
                    NicknameModifyForm(),
                    SizedBox(height: 1),
                    PasswordModifyForm(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
