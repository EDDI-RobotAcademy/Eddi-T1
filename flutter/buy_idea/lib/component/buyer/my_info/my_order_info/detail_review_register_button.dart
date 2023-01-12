import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../api/spring_review_api.dart';
import '../../../../pages/buyer/my_info/my_order_info/review/review_register_page.dart';

class DetailReviewRegisterButton extends StatefulWidget {
  const DetailReviewRegisterButton(
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
  State<DetailReviewRegisterButton> createState() =>
      _DetailReviewRegisterButtonState();
}

class _DetailReviewRegisterButtonState
    extends State<DetailReviewRegisterButton> {
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
          return Container(
            width: 115.0,
            child: TextButton(
                onPressed: () {
                  Get.to(ReviewRegisterPage(
                      productNo: widget.productNo,
                      productTitle: widget.productTitle));
                },
                child: const Text('리뷰 등록',
                    style: TextStyle(color: Color(0xFF2F4F4F), fontSize: 12)),
                style: ElevatedButton.styleFrom(
                    side:
                        const BorderSide(color: Color(0xFF2F4F4F), width: 1.0),
                    elevation: 0,
                    primary: Colors.white)),
          );
        } else {
          return Container(
              width: 115.0,
              child: TextButton(
                  onPressed: () {},
                  child: const Text('리뷰 등록',
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                  style: ElevatedButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      side: const BorderSide(color: Colors.grey, width: 1.0),
                      elevation: 0,
                      primary: Colors.white)));
        }
      } else {
        return Container(
            width: 115.0,
            child: TextButton(
                onPressed: () {},
                child: const Text('리뷰 등록',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                style: ElevatedButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    side: const BorderSide(color: Colors.grey, width: 1.0),
                    elevation: 0,
                    primary: Colors.white)));
      }
    } else {
      return Container(
          width: 115.0,
          child: TextButton(
              onPressed: () {},
              child: const Text('리뷰 등록',
                  style: TextStyle(color: Colors.grey, fontSize: 12)),
              style: ElevatedButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  side: const BorderSide(color: Colors.grey, width: 1.0),
                  elevation: 0,
                  primary: Colors.white)));
    }
  }
}
