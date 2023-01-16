import 'package:buy_idea/component/seller/order_management/product_order_count_widget.dart';
import 'package:buy_idea/component/seller/order_management/product_order_status_data.dart';
import 'package:flutter/material.dart';

class OrderStatusList extends StatefulWidget {
  const OrderStatusList({Key? key, required this.productOrderStatusList}) : super(key: key);
  final List<ProductOrderStatusData> productOrderStatusList;

  @override
  State<OrderStatusList> createState() => _OrderStatusListState();
}

class _OrderStatusListState extends State<OrderStatusList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.productOrderStatusList.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            iconColor: Colors.black,
            collapsedIconColor: Colors.black,
            childrenPadding: EdgeInsets.all(10),
            title: Row(
              children: [
                Text('[${widget.productOrderStatusList[index].category}] ', style: TextStyle(fontSize: 14),),
                Expanded(child: Text('${widget.productOrderStatusList[index].productTitle} ',
                    style: TextStyle(fontSize: 14),
                    maxLines: 1, overflow: TextOverflow.ellipsis)),
              ],
            ),
            children: [
              ProductOrderCountWidget(
                paymentCompleteCount: widget.productOrderStatusList[index].paymentCompleteCount,
                deliveringCount: widget.productOrderStatusList[index].deliveringCount,
                deliveredCount: widget.productOrderStatusList[index].deliveredCount,
                cancelCount: widget.productOrderStatusList[index].cancelCount,
                exchangeCount: widget.productOrderStatusList[index].exchangeCount,
                refundCount: widget.productOrderStatusList[index].refundCount,
                productImage: widget.productOrderStatusList[index].productImage,
              )
            ],
          );
        });
  }
}
