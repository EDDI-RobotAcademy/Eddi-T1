import 'package:flutter/cupertino.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("내 정보 임시 페이지", style: TextStyle(fontSize: 20),),
    );
  }
}
