import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/top_bar.dart';

class KnowhowPage extends StatefulWidget {
  const KnowhowPage({Key? key}) : super(key: key);

  @override
  State<KnowhowPage> createState() => _KnowhowPageState();
}

class _KnowhowPageState extends State<KnowhowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      body:
      Text("직업 노하우 임시 페이지", style: TextStyle(fontSize: 20),),
    );
  }
}
