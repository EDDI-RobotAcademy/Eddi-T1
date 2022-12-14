import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/top_bar.dart';
import '../../../component/buyer/home/home_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MainPageState();
}

class _MainPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
            child: HomeForm(),
          ),
        ],
      )),
    );
  }
}
