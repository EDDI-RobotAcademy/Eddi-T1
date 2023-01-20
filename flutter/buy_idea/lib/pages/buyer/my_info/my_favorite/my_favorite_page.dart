import 'package:flutter/material.dart';

import '../../../../component/buyer/app_bar/title_top_bar.dart';
import '../../../../component/buyer/my_info/my_favorite/my_favorite_form.dart';

class MyFavoritePage extends StatefulWidget {
  const MyFavoritePage({Key? key, required this.nickname}) : super(key: key);
  final String nickname;

  @override
  State<MyFavoritePage> createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TitleTopBar(titleText: '찜한 아이디어'),
        body: Column(
          children: [
            MyFavoriteForm(memberNickname: widget.nickname),
          ],
        ));
  }
}
