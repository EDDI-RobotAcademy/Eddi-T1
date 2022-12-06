import 'package:flutter/cupertino.dart';

class SignUpIdTextForm extends StatefulWidget{
  SignUpIdTextForm({Key? key, this.controller}) : super(key: key);

  final controller;
  static bool? buttonStates;

  @override
  State<SignUpIdTextForm> createState() => _SignUpIdTextFormState();
}