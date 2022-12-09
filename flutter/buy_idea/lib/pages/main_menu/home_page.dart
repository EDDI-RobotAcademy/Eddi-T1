import 'package:flutter/material.dart';

import '../../component/home/home_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Home 임시 페이지", style: TextStyle(fontSize: 20),),
    );
  }
}
