import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProductBuyAndShoppingCartSelectModalSheet extends StatefulWidget {
  final String seller;
  final String productTitle;
  final int productPrice;
  final int shippingCost;
  final int freeShippingCost;

  const ProductBuyAndShoppingCartSelectModalSheet({
    Key? key,
    required this.seller,
    required this.productTitle,
    required this.productPrice,
    required this.shippingCost,
    required this.freeShippingCost
  }) : super(key: key);

  @override
  State<ProductBuyAndShoppingCartSelectModalSheet> createState() => _ProductBuyAndShoppingCartSelectModalSheetState();
}

class _ProductBuyAndShoppingCartSelectModalSheetState extends State<ProductBuyAndShoppingCartSelectModalSheet> {

  int purchaseQuantity = 1;

  // 상품 금액이 숫자 세자리 넘어갈 때마다 콤마를 넣기 위한 intl 라이브러리를 통한 포맷 변수 초기화
  var f = NumberFormat('###,###,###,###');

  // 상품 수량 카운트 버튼 커스텀 위젯
  Widget CountButton(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if(purchaseQuantity > 1) {
                  setState(() {
                    purchaseQuantity--;
                  });
                } else {
                  // 사용자가 상품 수량이 1미만으로 설정하려고 할 시 띄워지는 alert dialog
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 20,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          content: Text('더이상 수량을 줄일 수 없습니다!', textAlign: TextAlign.center,),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('확인', style: TextStyle(color: Color(0xff2F4F4F)))
                            )
                          ],
                        );
                      }
                  );
                }
              },
              child: Icon(Icons.remove),
            ),
            Expanded(child: Text('$purchaseQuantity', textAlign: TextAlign.center,)),
            InkWell(
              onTap: () {
                setState(() {
                  purchaseQuantity++;
                });
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  // 무료배송 조건을 만족하지 못했을 때 배송비 및 무료배송 조건금액 명시
  Widget NotFreeShippingCost() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('배송비 ${f.format(widget.shippingCost)}원', style: TextStyle(fontSize: 12)),
        SizedBox(height: 5),
        Text('(${f.format(widget.freeShippingCost)}원 이상 구매 시 무료배송)', style: TextStyle(fontSize: 12, color: Colors.grey),)
      ],
    );
  }

  // 무료배송 조건을 만족했을 때 무료배송 명시
  Widget FreeShippingCost() {
    return Text('무료배송', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: Column(
        children: [
          Container(
            height: 5,
            width: 40,
            margin: EdgeInsets.only(top: 10, bottom: 5),
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20)
            ),
          ),
          Center(
            child: Text('상품 결제', style: TextStyle(fontSize: 14)),
          ),
          Divider(thickness: 0.8, height: 15),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/default_profile_image.png'),
                    ),
                    SizedBox(width: 10),
                    Text(widget.seller)
                  ],
                ),
                SizedBox(height: 10),
                Text(widget.productTitle, style: TextStyle(fontSize: 18), textAlign: TextAlign.start,)
              ],
            )
          ),
          Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CountButton(150, 40),
                    SizedBox(width: 10)
                  ],
                ),
              )
          ),
          SizedBox(height: 10),
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.black, width: 0.2)),
                color: Colors.white
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      widget.freeShippingCost > widget.productPrice * purchaseQuantity ?
                      NotFreeShippingCost() : FreeShippingCost(),
                      Expanded(child: SizedBox()),
                      Text('총 상품금액', style: TextStyle(fontSize: 12)),
                      SizedBox(width: 5),
                      Text('${f.format(widget.productPrice * purchaseQuantity)}원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                    ],
                  ),
                ),
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.white,
                        side: BorderSide(color: Colors.black26),
                        fixedSize: Size(190, 30)
                      ),
                      onPressed: () {

                      },
                      child: Text(
                        '장바구니',
                        style: TextStyle(color: Color(0xffDAA520))
                      )
                    ),
                    SizedBox(width: 5),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xff2F4F4F),
                        fixedSize: Size(190, 30)
                      ),
                      onPressed: () {

                      },
                      child: Text(
                        '구매하기',
                        style: TextStyle(color: Colors.white)
                      )
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
