import 'package:flutter/cupertino.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          child: Image(
              width: 250,
              height: 100,
              image: AssetImage("assets/buydia_logo.png")
          ),
          onTap: (){
            Navigator.pushNamed(context, "/mainPage");
          },
        )
      ],
    );
  }
}
