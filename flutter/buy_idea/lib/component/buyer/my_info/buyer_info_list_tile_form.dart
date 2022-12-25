import 'package:buy_idea/api/spring_member_api.dart';
import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../pages/account/sign_in_page.dart';
import '../../../pages/buyer/my_info/my_info_modify_page.dart';
import '../../../pages/buyer/my_info/service_center_page.dart';
import '../../common/common_alert_dialog.dart';
import '../../common/yes_or_no_alert_dialog.dart';

class BuyerInfoListTileForm extends StatefulWidget {
  const BuyerInfoListTileForm({Key? key, required this.memberNickname})
      : super(key: key);

  @override
  State<BuyerInfoListTileForm> createState() => _BuyerInfoListTileFormState();
  final String memberNickname;
}

class _BuyerInfoListTileFormState extends State<BuyerInfoListTileForm> {
  static const storage = FlutterSecureStorage();
  dynamic userToken = '';

  _logout() async {
    await storage.delete(key: 'userToken');
    await storage.delete(key: 'memberId');
    await storage.delete(key: 'nickname');
    await storage.delete(key: 'memberType');
  }

  _memberDelete() async {
    userToken = await storage.read(key: 'userToken');

    await SpringMemberApi().memberDelete(userToken.toString());
    if (SpringMemberApi.memberDeleteResponse.statusCode == 200) {
      debugPrint('통신 성공!');
      _logout();
      _memberDeleteSuccessShowDialog();
    } else {
      debugPrint('통신 실패');
      _memberDeleteFailShowDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.memberNickname == '비회원') {
      return Container(
        color: Colors.white,
        child: ListTile(
          onTap: () {
            Get.to(const SignInPage());
          },
          title: const Text('로그인 페이지로 이동',
              style: TextStyle(
                  color: Color(0xffDAA520), fontWeight: FontWeight.bold)),
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                Get.to(const MyInfoModifyPage());
              },
              title: const Text('내 정보 수정',
                  style: TextStyle(
                      color: Color(0xffDAA520), fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 1.0),
          Container(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                _logout();
                _signOutSuccessShowDialog();
              },
              title: const Text('로그아웃',
                  style: TextStyle(
                      color: Color(0xffDAA520), fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 1.0),
          Container(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                Get.to(const ServiceCenterPage());
              },
              title: const Text('고객 센터',
                  style: TextStyle(
                      color: Color(0xffDAA520), fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 1.0),
          Container(
            color: Colors.white,
            child: ListTile(
              onTap: () {
                _accountDeleteShowDialog();
              },
              title: const Text('회원 탈퇴',
                  style: TextStyle(
                      color: Color(0xffDAA520), fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      );
    }
  }

  /// 로그아웃 성공 alertDialog
  void _signOutSuccessShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
              title: '👋️',
              content: '안전하게 로그아웃 되었습니다.',
              onCustomButtonPressed: () {
                Get.offAll(const MainPage());
              });
        });
  }

  /// 회원 탈퇴 안내 alertDialog
  void _accountDeleteShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return YesOrNoAlertDialog(
            title: '⚠️',
            content: '한 번 탈퇴한 계정은 복구되지 않습니다.\n'
                '그래도 진행하시겠습니까?',
            yesButtonPressed: () {
              Get.back();
              _memberDelete();
            },
            noButtonPressed: () {
              Get.back();
            },
          );
        });
  }

  /// 회원 탈퇴 성공 alertDialog
  void _memberDeleteSuccessShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
              title: '👋️',
              content: '회원탈퇴가 완료되었습니다. \n'
                  '메인페이지로 이동합니다.',
              onCustomButtonPressed: () {
                Get.offAll(MainPage());
              });
        });
  }

  /// 회원 탈퇴 실패 alertDialog
  void _memberDeleteFailShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CommonAlertDialog(
            title: "⚠️",
            content: '죄송합니다. \n '
                '통신이 불안정하여 탈퇴가 실패했습니다.',
            onCustomButtonPressed: () {
              Get.back();
            },
          );
        });
  }
}
