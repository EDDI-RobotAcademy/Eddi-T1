import 'package:buy_idea/component/buyer/product/QnA/product_open_qna_card.dart';
import 'package:buy_idea/component/buyer/product/QnA/product_private_qna_card.dart';
import 'package:buy_idea/component/buyer/product/QnA/qna_register_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../api/spring_qna_api.dart';
import '../../my_info/my_order_info/QnA/my_question_history_card.dart';
import '../../my_info/my_order_info/QnA/my_question_history_info.dart';

class ProductQnaForm extends StatefulWidget {
  const ProductQnaForm(
      {Key? key,
      required this.productNo,
      required this.title,
      required this.image,
      required this.nickname})
      : super(key: key);
  final int productNo;
  final String title;
  final String image;
  final String nickname;

  @override
  State<ProductQnaForm> createState() => _ProductQnaFormState();
}

class _ProductQnaFormState extends State<ProductQnaForm> {
  List<MyQuestionHistoryInfo> myQnaHistoryList = [];
  static const _storage = FlutterSecureStorage();
  dynamic memberNickname = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();

    ///문의 내역 리스트 요청
    getQnaListAction();
  }

  void getQnaListAction() async {
    memberNickname = await _storage.read(key: 'nickname');

    setState(() {
      loading = false;
      memberNickname = memberNickname;
    });

    List<MyQuestionHistoryInfo> qnaLists =
        await SpringQnaApi().getQnaListByProductNo(widget.productNo);

    for (var i = 0; i < qnaLists.length; i++) {
      myQnaHistoryList.add(MyQuestionHistoryInfo(
          productNo: qnaLists[i].productNo,
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
          openStatus: qnaLists[i].openStatus,
          qnaNo: qnaLists[i].qnaNo));
    }

    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0XFF2F4F4F)),
      );
    } else {
      if (myQnaHistoryList.isEmpty) {
        return const Center(child: Text("현재 등록된 문의 내역이 없습니다."));
      } else {
        return SingleChildScrollView(
          child: Column(
            children: [
              QnaRegisterCard(
                nickname: widget.nickname,
                productNo: widget.productNo,
                image: widget.image,
                title: widget.title,
              ),
              const Divider(
                indent: 10,
                endIndent: 10,
                height: 20.0,
                thickness: 1,
              ),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: myQnaHistoryList.length,
                itemBuilder: (BuildContext context, int index) {
                  /// 내가 작성한 문의 일 때
                  if (memberNickname == myQnaHistoryList[index].writer) {
                    return MyQuestionHistoryCard(
                        productNo: myQnaHistoryList[index].productNo,
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
                        openStatus: myQnaHistoryList[index].openStatus,
                        qnaNo: myQnaHistoryList[index].qnaNo);
                    /// 다른 사람이 작성한 문의 글이 비공개 일 때
                  } else if (!myQnaHistoryList[index].openStatus) {
                    return ProductPrivateQnaCard(
                        writer: myQnaHistoryList[index].writer,
                        answerStatus: myQnaHistoryList[index].answerStatus,
                        regDate: myQnaHistoryList[index].regDate,
                        openStatus: myQnaHistoryList[index].openStatus);
                    /// 다른 사람이 작성한 문의 글이 공개일 때
                  } else {
                    return ProductOpenQnaCard(
                        productNo: myQnaHistoryList[index].productNo,
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
                  }
                },
              ),
            ],
          ),
        );
      }
    }
  }
}
