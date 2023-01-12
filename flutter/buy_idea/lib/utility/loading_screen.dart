import 'dart:async';

import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {

  final double width;
  final double height;
  Timer? timer;

  LoadingScreen({
    Key? key,
    required this.width,
    required this.height,
    this.timer,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    if(widget.timer != null) {
      widget.timer;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.white,
      child: const Center(
        child: Image(
          image: AssetImage('assets/buydia_animation_logo.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
