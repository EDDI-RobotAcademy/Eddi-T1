import 'package:flutter/material.dart';

class TitleTopBar extends StatefulWidget with PreferredSizeWidget {
  const TitleTopBar({Key? key, required this.titleText}) : super(key: key);
  final String titleText;

  @override
  State<TitleTopBar> createState() => _TitleTopBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TitleTopBarState extends State<TitleTopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.titleText,
          style: TextStyle(color: Colors.black, fontSize: 15)),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      elevation: 0.0,
      centerTitle: true,
    );
  }
}
