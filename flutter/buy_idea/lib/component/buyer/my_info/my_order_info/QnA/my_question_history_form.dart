import 'package:flutter/cupertino.dart';

import 'my_question_history_card.dart';

class MyQuestionHistoryForm extends StatefulWidget {
  const MyQuestionHistoryForm({Key? key}) : super(key: key);

  @override
  State<MyQuestionHistoryForm> createState() => _MyQuestionHistoryFormState();
}


@override
void initState() {
  // super.initState();
  ///문의 내역 리스트 요청
}

class _MyQuestionHistoryFormState extends State<MyQuestionHistoryForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyQuestionHistoryCard(),
        MyQuestionHistoryCard(),
      ],
    );
  }
}
