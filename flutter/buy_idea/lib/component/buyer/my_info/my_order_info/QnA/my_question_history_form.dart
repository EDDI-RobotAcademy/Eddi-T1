import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../api/spring_qna_api.dart';
import 'my_question_history_card.dart';
import 'my_question_history_info.dart';

class MyQuestionHistoryForm extends StatefulWidget {
  const MyQuestionHistoryForm({Key? key}) : super(key: key);

  @override
  State<MyQuestionHistoryForm> createState() => _MyQuestionHistoryFormState();
}

class _MyQuestionHistoryFormState extends State<MyQuestionHistoryForm> {
  static const _storage = FlutterSecureStorage();
  List<MyQuestionHistoryInfo> myQnaHistoryList = [];
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

    List<MyQuestionHistoryInfo> qnaLists =
        await SpringQnaApi().getQnaList(memberNickname);

    for (var i = 0; i < qnaLists.length; i++) {
      myQnaHistoryList.add(MyQuestionHistoryInfo(
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
      if (myQnaHistoryList.isEmpty) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 750,
          color: Colors.white,
          child: Center(
            child: Text(
                '현재 등록된 문의 내역이 없습니다.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
          ),
        );
      } else {
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: myQnaHistoryList.length,
          itemBuilder: (BuildContext context, int index) {
            return MyQuestionHistoryCard(
                productNo: myQnaHistoryList[index].productNo,
                qnaNo: myQnaHistoryList[index].qnaNo,
                title: myQnaHistoryList[index].title,
                writer: myQnaHistoryList[index].writer,
                nickname: myQnaHistoryList[index].nickname,
                questionCategory: myQnaHistoryList[index].questionCategory,
                questionTitle: myQnaHistoryList[index].questionTitle,
                questionContent: myQnaHistoryList[index].questionContent,
                answer: myQnaHistoryList[index].answer,
                answerStatus: myQnaHistoryList[index].answerStatus,
                regDate: myQnaHistoryList[index].regDate,
                updDate: myQnaHistoryList[index].updDate,
                openStatus: myQnaHistoryList[index].openStatus);
          },
        );
      }
    }
  }
}
