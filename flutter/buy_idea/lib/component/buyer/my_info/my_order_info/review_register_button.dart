import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../api/spring_review_api.dart';
import '../../../../pages/buyer/my_info/my_order_info/review/review_register_page.dart';

class ReviewRegisterButton extends StatefulWidget {
  const ReviewRegisterButton(
      {Key? key,
      required this.productNo,
      required this.orderStatus,
      required this.memberNickname,
      required this.productTitle})
      : super(key: key);
  final int productNo;
  final String orderStatus;
  final String memberNickname;
  final String productTitle;

  @override
  State<ReviewRegisterButton> createState() => _ReviewRegisterButtonState();
}

class _ReviewRegisterButtonState extends State<ReviewRegisterButton> {
  bool loading = false;
  bool check = true;

  @override
  void initState() {
    _reviewCheckAction(widget.productNo);
    super.initState();
  }

  _reviewCheckAction(int productNo) async {
    setState(() {
      loading = false;
    });
    var reviewCheck = await SpringReviewApi()
        .checkWriteReview(widget.memberNickname, widget.productNo);
    debugPrint("reviewCheck : " + reviewCheck.toString());
    setState(() {
      check = reviewCheck;
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      if (widget.orderStatus == 'DELIVERED') {
        if (!check) {
          return TextButton(
              onPressed: () {
                Get.to(ReviewRegisterPage(
                    productNo: widget.productNo,
                    productTitle: widget.productTitle));
              },
              child: const Text('리뷰등록',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              style: ElevatedButton.styleFrom(
                  elevation: 0, primary: Color(0xFF2F4F4F)));
        } else {
          return TextButton(
              onPressed: () {},
              child: const Text('리뷰등록',
                  style: TextStyle(color: Colors.white, fontSize: 12)),
              style:
                  ElevatedButton.styleFrom(elevation: 0, primary: Colors.grey));
        }
      } else {
        return TextButton(
            onPressed: () {},
            child: const Text('리뷰등록',
                style: TextStyle(color: Colors.white, fontSize: 12)),
            style:
                ElevatedButton.styleFrom(elevation: 0, primary: Colors.grey));
      }
    } else {
      return TextButton(
          onPressed: () {},
          child: const Text('리뷰등록',
              style: TextStyle(color: Colors.white, fontSize: 12)),
          style:
          ElevatedButton.styleFrom(elevation: 0, primary: Colors.grey));
    }
  }
}
