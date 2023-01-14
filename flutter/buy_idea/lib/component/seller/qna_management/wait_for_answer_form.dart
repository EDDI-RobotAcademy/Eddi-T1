import 'package:buy_idea/api/seller/spring_seller_qna_api.dart';
import 'package:buy_idea/component/seller/qna_management/top_count_widget.dart';
import 'package:buy_idea/component/seller/qna_management/wait_for_answer_history_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../buyer/my_info/my_order_info/QnA/my_question_history_info.dart';

class WaitForAnswerForm extends StatefulWidget {
  const WaitForAnswerForm({Key? key}) : super(key: key);

  @override
  State<WaitForAnswerForm> createState() => _WaitForAnswerFormState();
}

class _WaitForAnswerFormState extends State<WaitForAnswerForm> {
  static const _storage = FlutterSecureStorage();
  List<MyQuestionHistoryInfo> waitForAnswerList = [];

  bool loading = false;

  @override
  void initState() {
    super.initState();

    ///문의 내역 리스트 요청
    getQnaListAction();
  }

  void getQnaListAction() async {
    setState(() {
      loading = false;
    });

    dynamic memberNickname = await _storage.read(key: 'nickname');
    AnswerStatusRequest answerStatusRequest = AnswerStatusRequest(
        memberNickname, "답변 대기");

    List<MyQuestionHistoryInfo> qnaLists =
    await SpringSellerQnaApi().getAnswerStatusList(answerStatusRequest);

    for (var i = 0; i < qnaLists.length; i++) {
      waitForAnswerList.add(MyQuestionHistoryInfo(
          productNo: qnaLists[i].productNo,
          qnaNo: qnaLists[i].qnaNo,
          title: qnaLists[i].title,
          writer: qnaLists[i].writer,
          nickname: qnaLists[i].nickname,
          questionCategory: qnaLists[i].questionCategory,
          questionTitle: qnaLists[i].questionTitle,
          questionContent: qnaLists[i].questionContent,
          answer: qnaLists[i].answer,
          answerStatus: qnaLists[i].answerStatus,
          regDate: qnaLists[i].regDate,
          updDate: qnaLists[i].updDate,
          openStatus: qnaLists[i].openStatus));
    }

    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Center(
        child: CircularProgressIndicator(color: Color(0XFF2F4F4F)),
      );
    } else {
      if (waitForAnswerList.isEmpty) {
        return const Center(
            child: Text("답변 대기 상태의 문의 내역이 없습니다."));
      } else {
        return Column(
          children: [
            TopCountWidget(questionCount: waitForAnswerList.length, answerStatus: '답변 대기'),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: waitForAnswerList.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                    backgroundColor: Colors.white,
                    collapsedBackgroundColor: Colors.white,
                    iconColor: Colors.black,
                    collapsedIconColor: Colors.black,
                    childrenPadding: EdgeInsets.all(10),
                    title: Row(
                      children: [
                        Text('[${waitForAnswerList[index].questionCategory}] '),
                        Text(waitForAnswerList[index].title),
                      ],
                    ),
                    children: [
                      WaitForAnswerHistoryCard(
                productNo: waitForAnswerList[index].productNo,
                    qnaNo: waitForAnswerList[index].qnaNo,
                    title: waitForAnswerList[index].title,
                    writer: waitForAnswerList[index].writer,
                    nickname: waitForAnswerList[index].nickname,
                    questionCategory: waitForAnswerList[index].questionCategory,
                    questionTitle: waitForAnswerList[index].questionTitle,
                    questionContent: waitForAnswerList[index].questionContent,
                    answer: waitForAnswerList[index].answer,
                    answerStatus: waitForAnswerList[index].answerStatus,
                    regDate: waitForAnswerList[index].regDate,
                    updDate: waitForAnswerList[index].updDate,
                    openStatus: waitForAnswerList[index].openStatus)],
                );
              },
            ),
          ],
        );
      }
    }
  }
}
