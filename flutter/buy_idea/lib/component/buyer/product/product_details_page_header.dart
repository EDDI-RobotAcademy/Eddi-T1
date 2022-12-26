import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailsPageHeader extends StatefulWidget {
  final String seller;
  final String productTitle;
  final int productPrice;
  final int deliveryFee;
  final int freeDeliveryFee;
  final int stock;

  const ProductDetailsPageHeader({
    Key? key,
    required this.seller,
    required this.productTitle,
    required this.productPrice,
    required this.deliveryFee,
    required this.freeDeliveryFee,
    required this.stock
  }) : super(key: key);

  @override
  State<ProductDetailsPageHeader> createState() => _ProductDetailsPageHeaderState();
}

class _ProductDetailsPageHeaderState extends State<ProductDetailsPageHeader> {

  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {print('해당 판매자가 등록한 상품 리스트 페이지로 이동');},
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('assets/default_profile_image.png'),
                backgroundColor: Colors.white,
              ),
              SizedBox(width: 10),
              Text(widget.seller, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(width: 10),
              Icon(Icons.navigate_next)
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(widget.productTitle, style: TextStyle(fontSize: 20)),
        SizedBox(height: 10),
        Text('${f.format(widget.productPrice)}원', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('배송비', style: TextStyle(fontSize: 15, color: Colors.grey[600])),
            SizedBox(width: 10),
            Text('${f.format(widget.deliveryFee)} 원', style: TextStyle(fontSize: 15, color: Colors.black)),
            SizedBox(width: 5),
            Text('(${f.format(widget.freeDeliveryFee)}원 이상 구매 시 무료배송)', style: TextStyle(fontSize: 12, color: Colors.grey))
          ],
        ),
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('수량', style: TextStyle(fontSize: 15, color: Colors.grey[600])),
            SizedBox(width: 10),
            Text('${f.format(widget.stock)}', style: TextStyle(fontSize: 15, color: Colors.black))
          ],
        )
      ],
    );
  }
}
