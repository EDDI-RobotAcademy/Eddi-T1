class Validation {
  String? validateId(String text) {
    if(text.isEmpty) {
      return "아이디를 입력해주세요";
    } else if (RegExp(r"[0-9|a-z|A-Z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣]*$").hasMatch(text)) {
      return null;
    }
    return "1~8자 이내로 입력해주세요";
  }

  String? validatePassword(String text) {
    if(text.isEmpty) {
      return "비밀번호를 입력해주세요";
    }else if (RegExp(r"^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$").hasMatch(text)){
      return null;
    }
    return "8~16자 이내(영문,숫자.특수문자 필수)";
  }

  String? validateNickname(String text) {
    if(text.isEmpty) {
      return "닉네임을 입력해주세요";
    }
    return null;
  }
}

