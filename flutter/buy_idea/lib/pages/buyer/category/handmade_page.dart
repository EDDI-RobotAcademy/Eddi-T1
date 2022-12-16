import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/top_bar.dart';

class HandmadePage extends StatefulWidget {
  const HandmadePage({Key? key}) : super(key: key);

  @override
  State<HandmadePage> createState() => _HandmadePageState();
}

class _HandmadePageState extends State<HandmadePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(),
        body: Column(
          children: [
            Text("핸드메이드 임시 페이지", style: TextStyle(fontSize: 20)),
          ],
        ));
  }
}
