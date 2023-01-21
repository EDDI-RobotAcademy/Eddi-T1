import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'ip_info.dart';

class SpringMemberApi {
  static var signInResponse;
  static var memberDeleteResponse;
  static var memberNicknameModifyResponse;

  signInApi(MemberSignInRequest request) async {
    debugPrint("signApi()");
    var body = json.encode(request);

    try {
      signInResponse = await http.post(
        Uri.http(IpInfo.httpUri, '/member/sign-in'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  signUp(MemberSignUpRequest request) async {
    var body = json.encode(request);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/member/sign-up'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 성공");
    } else {
      debugPrint("통신 실패");
    }
  }

  memberDelete(String userToken) async {
    var body = json.encode(userToken);

    try {
      memberDeleteResponse = await http.post(
        Uri.http(IpInfo.httpUri, '/member/memberDrop/$userToken'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  memberNicknameModify(MemberNicknameModifyRequest request) async {
    var body = json.encode(request);

    try {
      memberNicknameModifyResponse = await http.post(
        Uri.http(IpInfo.httpUri, '/member/nickname-modify'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<DuplicateMemberIdResponse> memberIdDuplicateCheck(
      DuplicateMemberIdRequest request) async {
    var data = {"memberId": request.memberId};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/member/check-id/${request.memberId}'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신 성공");
    } else {
      debugPrint("통신 실패");
    }

    if (response.body == "true") {
      return DuplicateMemberIdResponse(true);
    } else {
      return DuplicateMemberIdResponse(false);
    }
  }

  Future<DuplicateNicknameResponse> nickNameDuplicateCheck(
      DuplicateNicknameRequest request) async {
    var data = {"nickname": request.nickname};
    var body = json.encode(data);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/member/check-nickname/${request.nickname}'),
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

  Map<String, dynamic> toJson() =>
      {'memberId': memberId, 'password': password, 'memberType': memberType};
}

class MemberSignUpRequest {
  String memberId;
  String password;
  String nickname;
  String memberType;

  MemberSignUpRequest(
      this.memberId, this.password, this.nickname, this.memberType);

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'password': password,
        'nickname': nickname,
        'memberType': memberType
      };
}

class MemberNicknameModifyRequest {
  String nickname;
  String currentNickname;

  MemberNicknameModifyRequest(this.nickname, this.currentNickname);

  Map<String, dynamic> toJson() =>
      {'nickname': nickname, 'currentNickname': currentNickname};
}

class DuplicateMemberIdResponse {
  bool? success;

  DuplicateMemberIdResponse(this.success);
}

class DuplicateMemberIdRequest {
  String memberId;

  DuplicateMemberIdRequest(this.memberId);
}

class DuplicateNicknameResponse {
  bool? success;

  DuplicateNicknameResponse(this.success);
}

class DuplicateNicknameRequest {
  String nickname;

  DuplicateNicknameRequest(this.nickname);
}
