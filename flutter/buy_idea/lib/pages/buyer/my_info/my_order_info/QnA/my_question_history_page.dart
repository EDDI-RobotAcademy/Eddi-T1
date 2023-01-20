import 'package:flutter/material.dart';

import '../../../../../component/buyer/app_bar/title_top_bar.dart';
import '../../../../../component/buyer/my_info/my_order_info/QnA/my_question_history_form.dart';

class MyQuestionHistoryPage extends StatefulWidget {
  const MyQuestionHistoryPage({Key? key}) : super(key: key);

  @override
  State<MyQuestionHistoryPage> createState() => _MyQuestionHistoryPageState();
}

class _MyQuestionHistoryPageState extends State<MyQuestionHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const TitleTopBar(titleText: '나의 문의'),
        body: SingleChildScrollView(
          child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
              child: MyQuestionHistoryForm())));
  }
}
