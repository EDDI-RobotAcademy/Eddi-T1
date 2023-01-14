import 'package:buy_idea/api/seller/spring_seller_qna_api.dart';
import 'package:buy_idea/component/seller/qna_management/top_count_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../buyer/my_info/my_order_info/QnA/my_question_history_info.dart';
import 'answer_complete_history_card.dart';

class AnswerCompleteForm extends StatefulWidget {
  const AnswerCompleteForm({Key? key}) : super(key: key);

  @override
  State<AnswerCompleteForm> createState() => _AnswerCompleteFormState();
}

class _AnswerCompleteFormState extends State<AnswerCompleteForm> {
  static const _storage = FlutterSecureStorage();
  List<MyQuestionHistoryInfo> answerCompleteList = [];

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
    AnswerStatusRequest answerStatusRequest =
        AnswerStatusRequest(memberNickname, "답변 완료");

    List<MyQuestionHistoryInfo> qnaLists =
        await SpringSellerQnaApi().getAnswerStatusList(answerStatusRequest);

    for (var i = 0; i < qnaLists.length; i++) {
      answerCompleteList.add(MyQuestionHistoryInfo(
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
      return Container(
        height: 620.0,
        child: Center(
          child: CircularProgressIndicator(color: Color(0XFF2F4F4F)),
        ),
      );
    } else {
      if (answerCompleteList.isEmpty) {
        return Container(
            height: 620.0,
            child: const Center(child: Text("답변 완료 상태의 문의 내역이 없습니다.")));
      } else {
        return Column(
          children: [
            TopCountWidget(
                questionCount: answerCompleteList.length,
                answerStatus: '답변 완료'),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: answerCompleteList.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                    backgroundColor: Colors.white,
                    collapsedBackgroundColor: Colors.white,
                    iconColor: Colors.black,
                    collapsedIconColor: Colors.black,
                    childrenPadding: EdgeInsets.all(10),
                    title: Row(
                      children: [
                        Text(
                            '[${answerCompleteList[index].questionCategory}] '),
                        Expanded(
                            child: Text(answerCompleteList[index].title,
                                maxLines: 1, overflow: TextOverflow.ellipsis)),
                      ],
                    ),
                    children: [
                      AnswerCompleteHistoryCard(
                          productNo: answerCompleteList[index].productNo,
                          qnaNo: answerCompleteList[index].qnaNo,
                          title: answerCompleteList[index].title,
                          writer: answerCompleteList[index].writer,
                          nickname: answerCompleteList[index].nickname,
                          questionCategory:
                              answerCompleteList[index].questionCategory,
                          questionTitle:
                              answerCompleteList[index].questionTitle,
                          questionContent:
                              answerCompleteList[index].questionContent,
                          answer: answerCompleteList[index].answer,
                          answerStatus: answerCompleteList[index].answerStatus,
                          regDate: answerCompleteList[index].regDate,
                          updDate: answerCompleteList[index].updDate,
                          openStatus: answerCompleteList[index].openStatus)
                    ]);
              },
            ),
          ],
        );
      }
    }
  }
}
