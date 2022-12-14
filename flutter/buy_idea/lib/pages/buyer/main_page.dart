import 'package:flutter/material.dart';

import '../../component/buyer/app_bar/bottom_bar.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BottomBar(),
      ),
    );
  }
}
