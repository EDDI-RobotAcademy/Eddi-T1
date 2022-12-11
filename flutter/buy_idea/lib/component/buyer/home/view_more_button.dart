import 'package:flutter/material.dart';

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton({Key? key, required this.onCustomButtonPressed}) : super(key: key);

  final VoidCallback onCustomButtonPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onCustomButtonPressed.call();
        },
        child: const Text("더 보기 〉 ", style: TextStyle(color: Colors.black)),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          side: BorderSide(color: Colors.black, width: 1.0),
          primary: Colors.white,
          minimumSize: Size(400, 40),
          padding: EdgeInsets.all(10.0),
        ));
  }
}
