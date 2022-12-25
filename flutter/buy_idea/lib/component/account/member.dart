class Member {
  String userToken;
  String memberId;
  String nickname;
  String memberType;

  Member(this.userToken, this.memberId, this.nickname, this.memberType);

  Member.fromJson(Map<String, dynamic> json)
      : userToken = json['userToken'],
        memberId = json['memberId'],
        nickname = json['nickname'],
        memberType = json['memberType'];

  Map<String, dynamic> toJson() => {
        'userToken': userToken,
        'memberId': memberId,
        'nickname': nickname,
        'memberType': memberType
      };
}

class MemberNickname {
  String memberId;
  String nickname;
  String memberType;

  MemberNickname(this.memberId, this.nickname, this.memberType);

  MemberNickname.fromJson(Map<String, dynamic> json)
      : memberId = json['memberId'],
        nickname = json['nickname'],
        memberType = json['memberType'];
}
