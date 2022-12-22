import 'package:flutter/material.dart';

class YesOrNoAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback yesButtonPressed;
  final VoidCallback noButtonPressed;

  YesOrNoAlertDialog(
      {required this.title,
        required this.content,
        required this.yesButtonPressed,
        required this.noButtonPressed,
      });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text("YES"),
          onPressed: () {
            yesButtonPressed.call();
          },
        ),
        TextButton(
          child: const Text("NO"),
          onPressed: () {
            noButtonPressed.call();
          },
        ),
      ],
      elevation: 20,
      titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20),
      contentTextStyle: const TextStyle(color: Colors.black, fontSize: 15),
      backgroundColor: Colors.white.withOpacity(0.7)
    );
  }
}
