class MyQuestionHistoryInfo {
  final int productNo;
  final String title;
  final String writer;
  final String nickname;
  final String questionCategory;
  final String questionTitle;
  final String questionContent;
  final String answer;
  final String answerStatus;
  final String regDate;
  final String updDate;
  final bool openStatus;

  MyQuestionHistoryInfo({
    required this.productNo,
    required this.title,
    required this.writer,
    required this.nickname,
    required this.questionCategory,
    required this.questionTitle,
    required this.questionContent,
    required this.answer,
    required this.answerStatus,
    required this.regDate,
    required this.updDate,
    required this.openStatus,
  });

  factory MyQuestionHistoryInfo.fromJson(Map<String, dynamic> json) {
    return MyQuestionHistoryInfo(
      productNo: json['productNo'],
      title: json['title'],
      writer: json['writer'],
      nickname: json['nickname'],
      questionCategory: json['questionCategory'],
      questionTitle: json['questionTitle'],
      questionContent: json['questionContent'],
      answer: json['answer'],
      answerStatus: json['answerStatus'],
      regDate: json['regDate'],
      updDate: json['updDate'],
      openStatus: json['openStatus'],
    );
  }
}
