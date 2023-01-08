import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'my_order_info_product.dart';

class MyOrderDetailInfoForm extends StatefulWidget {
  const MyOrderDetailInfoForm({Key? key,
    required this.myOrderSliceList,
    required this.orderNo,
    required this.orderDate, required this.memberNickname})
      : super(key: key);
  final List<MyOrderInfoProduct> myOrderSliceList;
  final String orderNo;
  final String orderDate;
  final String memberNickname;

  @override
  State<MyOrderDetailInfoForm> createState() => _MyOrderDetailInfoFormState();
}

class _MyOrderDetailInfoFormState extends State<MyOrderDetailInfoForm> {
  final List<Address> myOrderSliceAddressList = [];
  var totalPrice = 0;
  var totalDeliveryFee = 0;

  var f = NumberFormat('###,###,###,###');

  @override
  void initState() {
    _sliceMyOrderAddressList();
    for (var i = 0; i < widget.myOrderSliceList.length; i++) {
      debugPrint(widget.myOrderSliceList[i].price.toString() + '원');
      totalPrice +=
      (widget.myOrderSliceList[i].price * widget.myOrderSliceList[i].quantity);
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          padding: EdgeInsets.all(5.0),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/product/${widget
                                                    .myOrderSliceList[index]
                                                    .image}'))),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [

                                      /// 주문 상태
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: Text(
                                            widget.myOrderSliceList[index]
                                                .orderStatus,
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10.0),
                                            border: Border.all(
                                              color: Colors.grey,
                                              width: 1.0,
                                            )),
                                      ),
                                      SizedBox(height: 5.0),
                                      Container(
                                        width: 215.0,
                                        child: Text(
                                            widget
                                                .myOrderSliceList[index].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13)),
                                      ),
                                      Text(
                                          widget
                                              .myOrderSliceList[index].nickname,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Row(
                                        children: [
                                          Text(
                                              '${f.format(
                                                  widget.myOrderSliceList[index]
                                                      .price * widget
                                                      .myOrderSliceList[index]
                                                      .quantity)}원 | ',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            '${widget.myOrderSliceList[index]
                                                .quantity}개 | ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[800]),
                                          ),
                                          const Text('배송비 ',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey)),
                                          Text(
                                              '${f.format(
                                                  widget.myOrderSliceList[index]
                                                      .deliveryFee)}원',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey))
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 22.0),
                                  Column(
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            /// 문의 등록 페이지
                                          },
                                          child: const Text('문의하기',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12)),
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              primary: Color(0xFF2F4F4F)))
                                    ],
                                  )
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
                      Text(
                          '(${myOrderSliceAddressList[0]
                              .zipcode}) ${myOrderSliceAddressList[0].city} '
                              '${myOrderSliceAddressList[0]
                              .street} ${myOrderSliceAddressList[0]
                              .addressDetail}'
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
