import 'package:buy_idea/api/spring_product_api.dart';
import 'package:buy_idea/api/spring_review_api.dart';
import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:buy_idea/pages/buyer/my_info/my_order_info/review/review_modify_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyReviewForm extends StatefulWidget {
  final List<RequestMyReview> myReviewList;
  final List<RequestProductReviewImage> myReviewImageList;
  final List<RequestProductImage> productImageList;

  const MyReviewForm({
    Key? key,
    required this.myReviewList,
    required this.myReviewImageList,
    required this.productImageList
  }) : super(key: key);

  @override
  State<MyReviewForm> createState() => _MyReviewFormState();
}

class _MyReviewFormState extends State<MyReviewForm> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.myReviewList.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpansionTile(
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          iconColor: Colors.black,
          collapsedIconColor: Colors.black,
          childrenPadding: EdgeInsets.all(10),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: AssetImage('assets/product/${widget.productImageList[index].editedName}'),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.myReviewList[index].productTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            RatingBarIndicator(
                                rating: double.parse(widget.myReviewList[index].starRating.toString()),
                                itemSize: 10,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star_rate,
                                  color: Colors.amber,
                                )
                            ),
                            SizedBox(width: 10),
                            Text('|', style: TextStyle(fontSize: 11, color: Colors.grey),),
                            SizedBox(width: 10),
                            Text(
                              DateFormat('yyyy/MM/dd').format(DateTime.parse(widget.myReviewList[index].updDate)),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage('assets/review/${widget.myReviewImageList[index].editedName}'),
                  fit: BoxFit.cover
                )
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: RatingBarIndicator(
                    rating: double.parse(widget.myReviewList[index].starRating.toString()),
                    itemSize: 20,
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rate,
                      color: Colors.amber
                    )
                  ),
                ),
                Text(
                  DateFormat('yyyy/MM/dd hh:mm').format(DateTime.parse(widget.myReviewList[index].updDate)),
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
            Divider(thickness: 0.7, height: 20, color: Colors.grey,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(widget.myReviewList[index].content)
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            title: Text('⚠️ '),
                            content: Text(
                              '후기를 수정할 시\n이미지는 새로 등록해야합니다.\n그래도 수정하시겠습니까?',
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Get.off(ReviewModifyPage(
                                      reviewNo: widget.myReviewList[index].reviewNo,
                                      productTitle: widget.myReviewList[index].productTitle,
                                      content: widget.myReviewList[index].content,
                                      starRating: widget.myReviewList[index].starRating)
                                  );
                                },
                                child: Text('확인')
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text('취소', style: TextStyle(color: Colors.black),)
                              )
                            ],
                          );
                        }
                      );
                    },
                    child: Text('수정'),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xff2F4F4F),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext c) {
                              return AlertDialog(
                                backgroundColor: Colors.white.withOpacity(0.7),
                                title: Text('⚠️'),
                                content: Text(
                                  '후기를 정말 삭제하시겠습니까?',
                                  textAlign: TextAlign.center,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () async {
                                        Get.back();
                                        bool checkDelete = await SpringReviewApi().productReviewDelete(widget.myReviewList[index].reviewNo);
                                        if (checkDelete) {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white.withOpacity(0.7),
                                                title: Text('🗑️️'),
                                                content: Text(
                                                  '후기가 정상적으로 삭제되었습니다.\n메인페이지로 이동합니다.',
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Get.offAll(MainPage());
                                                    },
                                                    child: Text('확인')
                                                  ),
                                                ],
                                              );
                                            }
                                          );
                                        }
                                      },
                                      child: Text('확인')
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('취소', style: TextStyle(color: Colors.black),)
                                  )
                                ],
                              );
                            }
                        );
                      },
                    child: Text('삭제'),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xffDAA520),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      }
    );
  }
}
