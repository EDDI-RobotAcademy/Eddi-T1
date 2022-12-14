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
    'password': userToken,
    'memberId': memberId,
    'nickname': nickname,
    'memberType': memberType
  };
}