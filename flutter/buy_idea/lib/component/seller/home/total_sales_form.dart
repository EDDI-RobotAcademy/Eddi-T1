import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TotalSalesForm extends StatefulWidget {

  final int sales;

  const TotalSalesForm({
    Key? key,
    required this.sales
  }) : super(key: key);

  @override
  State<TotalSalesForm> createState() => _TotalSalesFormState();
}

class _TotalSalesFormState extends State<TotalSalesForm> {

  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 10,
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 80,
            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '총 매출',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                      ),
                      SizedBox(width: 10),
                      Tooltip(
                        margin: EdgeInsets.only(left: 15),
                        triggerMode: TooltipTriggerMode.tap,
                        message: '총 매출은 배송 완료 주문건에 한하여 집계된 금액입니다.',
                        showDuration: Duration(seconds: 5),
                        preferBelow: false,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Icon(Icons.help_outline, size: 20,),
                        ),
                      ),
                    ],
                  )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${f.format(widget.sales)}원', style: TextStyle(fontSize: 16)),
                  ],
                )
              ],
            ),
          ),
        )
      ]
    );
  }
}
