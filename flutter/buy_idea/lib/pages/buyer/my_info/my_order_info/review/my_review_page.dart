import 'package:buy_idea/api/spring_product_api.dart';
import 'package:buy_idea/api/spring_review_api.dart';
import 'package:buy_idea/component/buyer/app_bar/title_top_bar.dart';
import 'package:buy_idea/component/buyer/my_info/my_order_info/review/my_review_form.dart';
import 'package:flutter/material.dart';

class MyReviewPage extends StatefulWidget {
  final String writer;

  const MyReviewPage({
    Key? key,
    required this.writer
  }) : super(key: key);

  @override
  State<MyReviewPage> createState() => _MyReviewPageState();
}

class _MyReviewPageState extends State<MyReviewPage> {

  List<RequestMyReview> myReviewList = [];
  List<RequestProductReviewImage> myReviewImageList = [];
  List<RequestProductImage> productImageList = [];
  var future;

  _requestMyReviewList() async {
    myReviewList = await SpringReviewApi().myReviewList(widget.writer);
    for (RequestMyReview review in myReviewList) {
      myReviewImageList.add(await SpringReviewApi().reviewImage(review.reviewNo));
      productImageList.add(await SpringProductApi().productThumbnailImage(review.productNo));
    }
  }

  @override
  void initState() {
    future = _requestMyReviewList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // 메소드가 완료되지 않았다면 로딩표시 애니메이션을 화면에 띄움
          return Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 100,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff2F4F4F),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: TitleTopBar(titleText: '나의 후기'),
            body: myReviewList.isEmpty ?
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      '현재 등록된 구매 후기가 없습니다.',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                  ),
                )
            : SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                      color: Colors.white,
                      child: Text(
                        '내가 쓴 구매 후기 ${myReviewList.length}개',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: 5),
                    MyReviewForm(
                        myReviewList: myReviewList,
                        myReviewImageList: myReviewImageList,
                        productImageList: productImageList
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }
    );
  }
}
