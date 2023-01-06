import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyOrderInfoForm extends StatefulWidget {
  const MyOrderInfoForm({Key? key}) : super(key: key);

  @override
  State<MyOrderInfoForm> createState() => _MyOrderInfoFormState();
}

class _MyOrderInfoFormState extends State<MyOrderInfoForm> {
  final Uri _url = Uri.parse(
      'https://m.search.daum.net/search?nil_profile=btn&w=tot&DA=SBC&q=%EB%B0%B0%EC%86%A1%EC%A1%B0%ED%9A%8C');
  bool seeMore = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //나중에 다시 false 설정
    if (loading == true) {
      return Center(child: CircularProgressIndicator(color: Color(0XFF2F4F4F)));
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: Column(children: [
          Container(
            color: Colors.white,
            height: 50.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text('12036875890 | 2023.01.05',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ),
                    Expanded(child: SizedBox()),
                    TextButton(
                        onPressed: () {
                          /// 상품 상세정보 팝업창
                        },
                        child: Text('주문상세보기',
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF2F4F4F),
                                fontWeight: FontWeight.bold))),
                    Icon(Icons.keyboard_arrow_right)
                  ],
                ),
              ],
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 1,
              // products.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
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
                                            'assets/product/addf03d2-5f84-402a-996e-d5d6febc0d1cproduct19_1.jpg'))),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// 주문 상태
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text('주문 상태', style: TextStyle(fontSize: 12),),
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 5.0),
                                  Container(
                                    width: 205.0,
                                    child: Text('<Buydia 단독판매> 탄생화팔찌?소원팔찌?꽃팔찌',
                                        // products[index].title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                  ),
                                  Text('ANNAsSHOP',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                  SizedBox(height: 5.0),
                                  Row(
                                    children: [
                                      Text('5,000원 | ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        '1개 | ',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey[800]),
                                      ),
                                      Text('배송비 ',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text('3,000원',
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey))
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
                                      child: Text(
                                        '배송조회',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Color(0xFFDAA520),
                                      )),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        '리뷰등록',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        primary: Color(0xFF2F4F4F),
                                      )),
                                ],
                              )
                            ],
                          ),
                          Divider(color: Colors.grey, height: 30, thickness: 1),
                        ],
                      ),
                    )
                  ],
                );
              }),
        ]),
      );
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
}
