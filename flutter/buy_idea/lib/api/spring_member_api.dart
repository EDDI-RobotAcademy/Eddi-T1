import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SpringMemberApi {
  static const String httpUri = '192.168.56.1';
  static var signInResponse;

  signInApi(MemberSignInRequest request) async {
    var body = json.encode(request);

    try {
      signInResponse = await http.post(
        Uri.http(httpUri, '/member/sign-in'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

class MemberSignInRequest {
  String memberId;
  String password;

  MemberSignInRequest(this.memberId, this.password);

  Map<String, dynamic> toJson() => {'memberId': memberId, 'password': password};
}

