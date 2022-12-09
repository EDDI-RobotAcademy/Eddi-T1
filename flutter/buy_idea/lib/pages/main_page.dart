import 'package:buy_idea/component/common/app_bar/bottom_bar.dart';
import 'package:flutter/material.dart';

import '../component/common/app_bar/top_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body: Center(
        child: BottomBar(),),

    );
  }
}
