class Validation {
  String? validateId(String text) {
    if (text.isEmpty) {
      return "정보를 입력하세요";
    } else if (RegExp(
        r"^[a-zA-z0-9]{4,12}$")
        .hasMatch(text)) {
      return null;
    }
    return "아이디는 영문 대소문자와 숫자 4~12자리로 입력해야합니다!";
  }

  String? validatePassword(String text) {
    if (text.isEmpty) {
      return "정보를 입력하세요";
    }else if (RegExp(
        r"^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$")
        .hasMatch(text)) {
      return null;
    }
    return "영문, 숫자, 특수문자를 포함한 8~16자를 입력해주세요.";
  }
}