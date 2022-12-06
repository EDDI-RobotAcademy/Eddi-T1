import 'package:buy_idea/pages/account/login_page.dart';
import 'package:buy_idea/pages/account/select_sign_up_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'signUp',
      initialRoute: "/login",
      routes: {
        "/login": (context) => LoginPage(), //
      },
    );
  }
}
