import 'package:flutter/cupertino.dart';

class HobbyPage extends StatefulWidget {
  const HobbyPage({Key? key}) : super(key: key);

  @override
  State<HobbyPage> createState() => _HobbyPageState();
}

class _HobbyPageState extends State<HobbyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("취미/특기 임시 페이지", style: TextStyle(fontSize: 20),),
    );
  }
}
