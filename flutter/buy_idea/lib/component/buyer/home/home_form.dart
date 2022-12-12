import 'package:buy_idea/component/buyer/home/view_more_button.dart';
import 'package:buy_idea/utility/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../pages/buyer/category/handmade_page.dart';
import '../../../pages/buyer/category/hobby_page.dart';
import '../../../pages/buyer/category/knowhow_page.dart';
import 'home_banner.dart';
import 'home_handmade.dart';

class HomeForm extends StatefulWidget {
  const HomeForm({Key? key}) : super(key: key);

  @override
  State<HomeForm> createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  static const _storage = FlutterSecureStorage();
  dynamic nickname = '';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _memberInfoRead();
    });
  }

  /// 회원 정보 불러오기
  Future<void> _memberInfoRead() async {
    try {
      nickname = await _storage.read(key: 'nickname');
      if (nickname == null) {
        setState(() {
          nickname = "방문객";
        });
      } else {
        setState(() {
          nickname = nickname;
        });
        debugPrint('회원 접속중');
      }
    } catch (e) {
      debugPrint('e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: medium_gap),
        HomeBanner(),
        SizedBox(height: 30),
        HomeCategoryProduct(nicknameInfo: nickname, category: '핸드메이드'),
        ViewMoreButton(onCustomButtonPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HandmadePage()));
        }),
        SizedBox(height: 30),
        HomeCategoryProduct(nicknameInfo: nickname, category: '직업 노하우'),
        ViewMoreButton(onCustomButtonPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const KnowhowPage()));
        }),
        SizedBox(height: 30),
        HomeCategoryProduct(nicknameInfo: nickname, category: '취미/특기'),
        ViewMoreButton(onCustomButtonPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HobbyPage()));
        }),
        SizedBox(height: 30),
      ],
    );
  }
}
