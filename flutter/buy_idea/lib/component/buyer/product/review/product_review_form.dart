import 'package:buy_idea/api/spring_review_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ProductReviewForm extends StatefulWidget {
  final int productNo;
  final int reviewSize;
  final int nextReviewSize;
  final int reviewCount;
  
  const ProductReviewForm({
    Key? key,
    required this.productNo,
    required this.reviewSize,
    required this.nextReviewSize,
    required this.reviewCount
  }) : super(key: key);

  @override
  State<ProductReviewForm> createState() => _ProductReviewFormState();
}

class _ProductReviewFormState extends State<ProductReviewForm> {
  
  List<RequestProductReview> reviewList = [];
  List<RequestProductReviewImage> reviewImageList = [];

  bool moreReviews = false;

  var future;
  
  _requestReviewList() async {
    reviewList = await SpringReviewApi().productReviewList(widget.productNo, widget.reviewSize);
    for (RequestProductReview review in reviewList) {
      reviewImageList.add(await SpringReviewApi().reviewImage(review.reviewNo));
    }
    if (reviewList.length == widget.reviewSize) {
      setState(() {
        moreReviews = true;
      });
    }
  }

  _requestNextReviewList() async {
    List<RequestProductReview> nextReviewList = await SpringReviewApi().nextProductReviewList(
        widget.productNo, reviewList.last.reviewNo, widget.nextReviewSize);
    for (RequestProductReview review in nextReviewList) {
      reviewList.add(review);
      reviewImageList.add(await SpringReviewApi().reviewImage(review.reviewNo));
    }
    setState(() {
      reviewList;
      reviewImageList;
    });
    if (reviewList.length == widget.reviewCount) {
      setState(() {
        moreReviews = false;
      });
    }
  }

  @override
  void initState() {
    future = _requestReviewList();
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
            return reviewList.isNotEmpty ? SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 15, right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('구매후기 (${widget.reviewCount})', style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    Divider(indent: 10, endIndent: 10, height: 0, thickness: 1,),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: reviewList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(15),
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                height: 200,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: AssetImage('assets/default_profile_image.png'),
                                          backgroundColor: Colors.white,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text(
                                              reviewList[index].writer,
                                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)
                                            ),
                                            SizedBox(height: 5),
                                            Row(
                                              children: [
                                                RatingBarIndicator(
                                                    itemSize: 10,
                                                    rating: reviewList[index].starRating.toDouble(),
                                                    itemBuilder: (context, _) => Icon(
                                                          Icons.star_rate,
                                                          color: Colors.amber,
                                                        )
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  DateFormat('yyyy/MM/dd').format(DateTime.parse(reviewList[index].updDate)),
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.grey
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      height: 120,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Container(
                                            width: 120,
                                            height: 120,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage('assets/review/${reviewImageList[index].editedName}'),
                                                fit: BoxFit.cover
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: Colors.grey,
                                            thickness: 1,
                                            indent: 5,
                                            endIndent: 5,
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: SingleChildScrollView(
                                              child: Text(
                                                reviewList[index].content,
                                                style: TextStyle(fontSize: 12),
                                                textAlign: TextAlign.start,
                                                maxLines: 100,
                                              )
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                height: 0,
                                thickness: 1,
                              )
                            ],
                          );
                        }
                    ),
                    if (moreReviews)
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: ElevatedButton(
                          onPressed: _requestNextReviewList,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                '구매 후기 더보기',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  color: Color(0xffDAA520)
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.keyboard_arrow_down, size: 20, color: Color(0xffDAA520),)
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Color(0xffDAA520)),
                            fixedSize: Size(200, 40)
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ) :
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Center(
                child: Text(
                    '현재 등록된 구매 후기가 없습니다.'),
              ),
            );
          }
        }
    );
  }
}
