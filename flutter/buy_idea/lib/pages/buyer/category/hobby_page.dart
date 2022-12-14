import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/top_bar.dart';

class HobbyPage extends StatefulWidget {
  const HobbyPage({Key? key}) : super(key: key);

  @override
  State<HobbyPage> createState() => _HobbyPageState();
}

class _HobbyPageState extends State<HobbyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body:
      Text("취미/특기 임시 페이지", style: TextStyle(fontSize: 20),),
    );
  }
}
