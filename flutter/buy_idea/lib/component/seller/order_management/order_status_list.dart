import 'package:buy_idea/component/seller/order_management/product_order_count_widget.dart';
import 'package:flutter/material.dart';

class OrderStatusList extends StatefulWidget {
  const OrderStatusList({Key? key}) : super(key: key);

  @override
  State<OrderStatusList> createState() => _OrderStatusListState();
}

class _OrderStatusListState extends State<OrderStatusList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            iconColor: Colors.black,
            collapsedIconColor: Colors.black,
            childrenPadding: EdgeInsets.all(10),
            title: Row(
              children: [
                Text('[핸드메이드] ', style: TextStyle(fontSize: 14),),
                Expanded(child: Text('집들이 💝 선물 추천 🌸 꽃 향기 디퓨저 ',
                    style: TextStyle(fontSize: 14),
                    maxLines: 1, overflow: TextOverflow.ellipsis)),
              ],
            ),
            children: [
              ProductOrderCountWidget(
                paymentCompleteCount: 1,
                deliveringCount: 12,
                deliveredCount: 4,
                cancelCount: 1,
                exchangeCount: 2,
                refundCount: 0,
                productImage: 'handmade7.jpg',
              )
            ],
          );
        });
  }
}
