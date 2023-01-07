import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'my_order_info_product.dart';

class MyOrderInfoForm extends StatefulWidget {
  const MyOrderInfoForm(
      {Key? key, required, required this.orderNo, required this.orderDate})
      : super(key: key);

  final String orderNo;
  final String orderDate;

  @override
  State<MyOrderInfoForm> createState() => _MyOrderInfoFormState();
}

class _MyOrderInfoFormState extends State<MyOrderInfoForm> {
  final Uri _url = Uri.parse(
      'https://m.search.daum.net/search?nil_profile=btn&w=tot&DA=SBC&q=%EB%B0%B0%EC%86%A1%EC%A1%B0%ED%9A%8C');
  int setItemCount = 2;
  var f = NumberFormat('###,###,###,###');
  final List<MyOrderInfoProduct> myOrderSliceList = [];

  @override
  void initState() {
    _sliceMyOrderInfoList();
    super.initState();
  }

  _sliceMyOrderInfoList() {
    myOrderSliceList.clear();
    for (var i = 0; i < myOrderInfoList.length; i++) {
      if (myOrderInfoList[i].orderNo == widget.orderNo) {
        myOrderSliceList.add(myOrderInfoList[i]);
      }
    }
    setState(() {
      if (myOrderSliceList.length < 2) {
        setItemCount = 1;
      }
    });
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text('${widget.orderNo} | ${widget.orderDate}',
                      style: TextStyle(fontSize: 14, color: Colors.grey)),
                ),
                const Expanded(child: SizedBox()),
                TextButton(
                    onPressed: () {
                      /// 상품 상세정보 팝업창
                    },
                    child: const Text('주문상세보기',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF2F4F4F),
                            fontWeight: FontWeight.bold))),
                Icon(Icons.keyboard_arrow_right)
              ],
            ),
            const Divider(color: Color(0xFFf5f5f5), height: 2.0, thickness: 2),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: setItemCount,
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
                                  Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/product/${myOrderSliceList[index].image}'))),
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
                                            myOrderSliceList[index].orderStatus,
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
                                            myOrderSliceList[index].title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13)),
                                      ),
                                      Text(myOrderSliceList[index].nickname,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Row(
                                        children: [
                                          Text(
                                              '${f.format(myOrderSliceList[index].price * myOrderSliceList[index].quantity)}원 | ',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                          Text(
                                            '${myOrderSliceList[index].quantity}개 | ',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey[800]),
                                          ),
                                          const Text('배송비 ',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey)),
                                          Text(
                                              '${f.format(myOrderSliceList[index].deliveryFee)}원',
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
                                            _launchURL();
                                          },
                                          child: const Text(
                                            '배송조회',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: Color(0xFFDAA520),
                                          )),
                                      TextButton(
                                          onPressed: () {},
                                          child: const Text(
                                            '리뷰등록',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            elevation: 0,
                                            primary: Color(0xFF2F4F4F),
                                          )),
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
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (myOrderSliceList.length > 2)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                      child: Text('외 주문 ${myOrderSliceList.length - 2}건',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    )
                ])
          ],
        ),
      ),
    );
  }

  _launchURL() async {
    debugPrint('_launchURL()');
    if (await launchUrl(_url)) {
      await canLaunchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }
}
