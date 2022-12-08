import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SpringMemberApi {
  static const String httpUri = '172.30.1.67:8888';
  static var signInResponse;

  signInApi(MemberSignInRequest request) async {
    debugPrint("signApi");
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

  signUp(MemberSignUpRequest request) async{
    var body = json.encode(request);

    var response = await http.post(
      Uri.http(httpUri, '/member/sign-up'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 성공");

    }else{
      debugPrint("통신 실패");
    }
  }

  Future<DuplicateMemberIdResponse> memberIdDuplicateCheck(DuplicateMemberIdRequest request)
  async{
    var data = {"memberId": request.memberId};
    var body = json.encode(data);

    var response = await http.post(
        Uri.http(httpUri, '/member/check-id/${request.memberId}'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );


    if (response.statusCode == 200) {
      debugPrint("통신 성공");

    }else{
      debugPrint("통신 실패");
    }

    if(response.body == "true"){
      return DuplicateMemberIdResponse(true);
    } else {
      return DuplicateMemberIdResponse(false);
    }
  }

  Future<DuplicateNicknameResponse> nickNameDuplicateCheck (DuplicateNicknameRequest request)
  async {
    var data = {"nickName": request.nickname
    };
    var body = json.encode(data);


    var response = await http.post(
      Uri.http(httpUri, '/member/check-nickname/${request.nickname}'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 성공");
    } else {
      debugPrint("통신 실패");
    }

    if (response.body == "true") {
      return DuplicateNicknameResponse(true);
    } else {
      return DuplicateNicknameResponse(false);
    }
  }
}

class MemberSignInRequest {
  String memberId;
  String password;
  String memberType;

  MemberSignInRequest(this.memberId, this.password, this.memberType);

  Map<String, dynamic> toJson() => {'memberId': memberId, 'password': password, 'memberType': memberType};
}

class MemberSignUpRequest {
  String memberId;
  String password;
  String nickname;
  String memberType;

  MemberSignUpRequest(this.memberId, this.password, this.nickname, this.memberType);
  Map<String, dynamic> toJson() => {'memberId': memberId, 'password': password, 'nickName': nickname, "memberType": memberType};
}

class DuplicateMemberIdResponse{
  bool? success;

  DuplicateMemberIdResponse(this.success);
}

class DuplicateMemberIdRequest{
  String memberId;

  DuplicateMemberIdRequest(this.memberId);
}

class DuplicateNicknameResponse{
  bool? success;

  DuplicateNicknameResponse(this.success);
}

class DuplicateNicknameRequest{
  String nickname;

  DuplicateNicknameRequest(this.nickname);
}