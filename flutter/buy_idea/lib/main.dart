import 'package:buy_idea/pages/account/sign_in_page.dart';
import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'signUp',
        initialRoute: "/main-page",
        routes: {
          "/sign-in": (context) => const SignInPage(),
          "/main-page" : (context) => const MainPage(),
        },
      ),
    );
  }
}
