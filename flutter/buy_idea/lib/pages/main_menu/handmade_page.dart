import 'package:flutter/cupertino.dart';

class HandmadePage extends StatefulWidget {
  const HandmadePage({Key? key}) : super(key: key);

  @override
  State<HandmadePage> createState() => _HandmadePageState();
}

class _HandmadePageState extends State<HandmadePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("핸드메이드 임시 페이지", style: TextStyle(fontSize: 20),),
    );
  }
}
