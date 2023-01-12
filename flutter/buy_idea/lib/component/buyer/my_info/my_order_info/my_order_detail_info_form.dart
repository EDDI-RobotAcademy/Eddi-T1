import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../api/spring_review_api.dart';
import '../../../../pages/buyer/my_info/my_order_info/QnA/question_register_page.dart';
import '../../../../pages/buyer/product/product_details_page.dart';
import 'detail_review_register_button.dart';
import 'my_order_info_product.dart';
import 'order_status_set_string.dart';

class MyOrderDetailInfoForm extends StatefulWidget {
  const MyOrderDetailInfoForm(
      {Key? key,
      required this.myOrderSliceList,
      required this.orderNo,
      required this.orderDate,
      required this.memberNickname})
      : super(key: key);
  final List<MyOrderInfoProduct> myOrderSliceList;
  final String orderNo;
  final String orderDate;
  final String memberNickname;

  @override
  State<MyOrderDetailInfoForm> createState() => _MyOrderDetailInfoFormState();
}

class _MyOrderDetailInfoFormState extends State<MyOrderDetailInfoForm> {
  final Uri _url = Uri.parse(
      'https://m.search.daum.net/search?nil_profile=btn&w=tot&DA=SBC&q=%EB%B0%B0%EC%86%A1%EC%A1%B0%ED%9A%8C');
  final List<Address> myOrderSliceAddressList = [];
  var totalPrice = 0;
  var totalDeliveryFee = 0;
  bool check = true;
  var f = NumberFormat('###,###,###,###');

  @override
  void initState() {
    _sliceMyOrderAddressList();
    for (var i = 0; i < widget.myOrderSliceList.length; i++) {
      debugPrint(widget.myOrderSliceList[i].price.toString() + '원');
      totalPrice += (widget.myOrderSliceList[i].price *
          widget.myOrderSliceList[i].quantity);
    }
    for (var i = 0; i < widget.myOrderSliceList.length; i++) {
      totalDeliveryFee += widget.myOrderSliceList[i].deliveryFee;
    }
    super.initState();
  }

  _sliceMyOrderAddressList() {
    myOrderSliceAddressList.clear();
    for (var i = 0; i < myOrderAddressList.length; i++) {
      if (myOrderAddressList[i].orderNo == widget.orderNo) {
        myOrderSliceAddressList.add(myOrderAddressList[i]);
      }
    }
  }

  _launchURL() async {
    debugPrint('_launchURL()');
    if (await launchUrl(_url)) {
      await canLaunchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _reviewCheckAction(int productNo) async {
    check = await SpringReviewApi()
        .checkWriteReview(widget.memberNickname, productNo);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30.0,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('${widget.orderNo} | ${widget.orderDate}',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
              ),
            ),
            const Divider(color: Color(0xFFf5f5f5), height: 2.0, thickness: 2),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.myOrderSliceList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(5.0),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(ProductDetailsPage(
                                          productNo: widget
                                              .myOrderSliceList[index]
                                              .productNo));
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  'assets/product/${widget.myOrderSliceList[index].image}'))),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /// 주문 상태
                                      Text(
                                        '• ${OrderStatusTypeChange().setString(widget.myOrderSliceList[index].orderStatus)}',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width: 275.0,
                                        child: Text(
                                            widget
                                                .myOrderSliceList[index].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13)),
                                      ),
                                      SizedBox(height: 4.0),
                                      Text(
                                          widget
                                              .myOrderSliceList[index].nickname,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      SizedBox(height: 2.0),
                                      Row(
                                        children: [
                                          Text(
                                              '${f.format(widget.myOrderSliceList[index].price * widget.myOrderSliceList[index].quantity)}원 | ',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            '${widget.myOrderSliceList[index].quantity}개 | ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[800]),
                                          ),
                                          const Text('배송비 ',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey)),
                                          Text(
                                              '${f.format(widget.myOrderSliceList[index].deliveryFee)}원',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey))
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 22.0),
                                ],
                              ),
                              SizedBox(height: 20.0),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          _launchURL();
                                        },
                                        child: const Text(
                                          '배송 조회',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          side: const BorderSide(
                                              color: Colors.black, width: 1.0),
                                          elevation: 0,
                                          primary: Colors.white,
                                        )),
                                  ),
                                  SizedBox(width: 20.0),
                                  Expanded(
                                    child: TextButton(
                                        onPressed: () {
                                          /// 문의 등록 페이지
                                          Get.to(QuestionRegisterPage(
                                            productNo: widget
                                                .myOrderSliceList[index]
                                                .productNo,
                                            productImage: widget
                                                .myOrderSliceList[index].image,
                                            productTitle: widget
                                                .myOrderSliceList[index].title,
                                            nickname: widget
                                                .myOrderSliceList[index]
                                                .nickname,
                                          ));
                                        },
                                        child: const Text('문의하기',
                                            style: TextStyle(
                                                color: Color(0xFFDAA520),
                                                fontSize: 12)),
                                        style: ElevatedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Color(0xFFDAA520),
                                                width: 1.0),
                                            elevation: 0,
                                            primary: Colors.white)),
                                  ),
                                  SizedBox(width: 20.0),
                                  Row(
                                    children: [
                                      DetailReviewRegisterButton(
                                          productNo: widget
                                              .myOrderSliceList[index]
                                              .productNo,
                                          orderStatus: widget
                                              .myOrderSliceList[index]
                                              .orderStatus,
                                          memberNickname: widget.memberNickname,
                                          productTitle: widget
                                              .myOrderSliceList[index].title)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20.0),
                              const Divider(
                                  color: Color(0xFFf5f5f5),
                                  height: 2.0,
                                  thickness: 2),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('배송지 정보',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start)
                    ],
                  ),
                  const Divider(
                      color: Color(0xFFf5f5f5), height: 40.0, thickness: 2),
                  Row(
                    children: [
                      SizedBox(
                          width: 80.0,
                          child: Text(
                            '받는 사람',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          )),
                      Text(
                        myOrderSliceAddressList[0].recipient,
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                          width: 80.0,
                          child: Text(
                            '연락처',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          )),
                      Text(
                        myOrderSliceAddressList[0].phone,
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                          width: 80.0,
                          child: Text(
                            '주소',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          )),
                      SizedBox(
                        width: 300.0,
                        child: Text(
                            '(${myOrderSliceAddressList[0].zipcode}) ${myOrderSliceAddressList[0].city} '
                            '${myOrderSliceAddressList[0].street} ${myOrderSliceAddressList[0].addressDetail}'),
                      )
                    ],
                  ),
                  SizedBox(height: 60.0),
                  Row(
                    children: [
                      Text('결제 정보',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start),
                    ],
                  ),
                  const Divider(
                      color: Color(0xFFf5f5f5), height: 40.0, thickness: 2),
                  Row(
                    children: [
                      SizedBox(
                          width: 80.0,
                          child: Text(
                            '상품 금액',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          )),
                      Expanded(child: SizedBox()),
                      Text(
                        '${f.format(totalPrice)}원',
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                          width: 80.0,
                          child: Text(
                            '배송비',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          )),
                      Expanded(child: SizedBox()),
                      Text(
                        '${f.format(totalDeliveryFee)}원',
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                          width: 80.0,
                          child: Text(
                            '결제 금액',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          )),
                      Expanded(child: SizedBox()),
                      Text(
                        '${f.format(totalPrice + totalDeliveryFee)}원',
                      )
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                          width: 80.0,
                          child: Text(
                            '주문자',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.start,
                          )),
                      Expanded(child: SizedBox()),
                      Text(
                        '닉네임(${widget.memberNickname})님',
                      )
                    ],
                  ),
                  SizedBox(height: 60.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
