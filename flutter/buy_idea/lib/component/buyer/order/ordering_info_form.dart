import 'package:buy_idea/api/spring_product_api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderingInfoForm extends StatefulWidget {
  final List<RequestProduct> products;
  final List<RequestProductImage> productImages;
  final List<int> purchaseQuantityList;

  const OrderingInfoForm({
    Key? key,
    required this.products,
    required this.productImages,
    required this.purchaseQuantityList
  }) : super(key: key);

  @override
  State<OrderingInfoForm> createState() => _OrderingInfoFormState();
}

class _OrderingInfoFormState extends State<OrderingInfoForm> {

  bool seeMore = false;

  var f = NumberFormat('###,###,###,###');

  int _getProductTotalPrice() {
    int total = 0;
    for(int i = 0; i < widget.products.length; i++) {
      total += widget.products[i].price * widget.purchaseQuantityList[i];
    }
    return total;
  }

  _getTotalDeliveryFee() {
    int total = 0;
    for (int i = 0; i < widget.products.length; i++) {
      if (widget.products[i].price * widget.purchaseQuantityList[i] < 50000) {
        total += widget.products[i].deliveryFee;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (seeMore == false) {
              setState(() {
                seeMore = true;
              });
            } else {
              setState(() {
                seeMore = false;
              });
            }
          },
          child: Container(
            padding: EdgeInsets.all(15),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('주문 상품 정보', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (widget.products.length < 2)
                        Expanded(child: Text('${widget.products[0].title}', style: TextStyle(fontSize: 11)))
                      else
                        Expanded(child: Text('${widget.products[0].title} 외 ${widget.products.length - 1}건', style: TextStyle(fontSize: 11))),
                      SizedBox(width: 5),
                      seeMore // 더보기 상태가 아니라면 아래쪽 화살표 / 더보기 상태라면 위쪽 화살표
                          ? Icon(Icons.keyboard_arrow_up)
                          : Icon(Icons.keyboard_arrow_down)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        if (seeMore == true) ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.products.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Text(widget.products[index].nickname, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage('assets/product/${widget.productImages[index].editedName}')
                                  )
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(widget.products[index].title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                                child: Text('수량 : ${widget.purchaseQuantityList[index]}개', style: TextStyle(fontSize: 12),)
                            ),
                            Text('${f.format(widget.products[index].price * widget.purchaseQuantityList[index])}원', style: TextStyle(fontSize: 12))
                          ],
                        ),
                        Divider(color: Colors.grey, height: 30, thickness: 1),
                        Row(
                          children: [
                            Expanded(
                                child: Text('배송비', style: TextStyle(fontSize: 12))
                            ),
                            if (widget.products[index].price * widget.purchaseQuantityList[index] < 50000)
                              Text('${f.format(widget.products[index].deliveryFee)}원', style: TextStyle(fontSize: 12))
                            else
                              Text('무료배송')
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            }
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('결제 정보', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: Text('상품 금액', style: TextStyle(fontSize: 12))),
                  Text('${f.format(_getProductTotalPrice())}원', style: TextStyle(fontSize: 12))
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: Text('배송비', style: TextStyle(fontSize: 12))),
                  if (_getTotalDeliveryFee() == 0)
                    Text('무료배송', style: TextStyle(fontSize: 12))
                  else
                    Text('${f.format(_getTotalDeliveryFee())}원', style: TextStyle(fontSize: 12))
                ],
              ),
              Divider(color: Colors.grey, height: 30, thickness: 1),
              Row(
                children: [
                  Expanded(child: Text('최종 결제 금액', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))),
                  Text('${f.format(_getProductTotalPrice() + _getTotalDeliveryFee())}원', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
