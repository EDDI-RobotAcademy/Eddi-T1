import 'package:flutter/material.dart';

class ProductOrderCountWidget extends StatefulWidget {
  const ProductOrderCountWidget(
      {Key? key,
      required this.paymentCompleteCount,
      required this.deliveringCount,
      required this.deliveredCount,
      required this.cancelCount,
      required this.exchangeCount,
      required this.refundCount,
      required this.productImage})
      : super(key: key);
  final int paymentCompleteCount;
  final int deliveringCount;
  final int deliveredCount;
  final int cancelCount;
  final int exchangeCount;
  final int refundCount;
  final String productImage;

  @override
  State<ProductOrderCountWidget> createState() =>
      _ProductOrderCountWidgetState();
}

class _ProductOrderCountWidgetState extends State<ProductOrderCountWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/product/${widget.productImage}",
            width: 80, height: 80),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: Text(
                              '결제 완료 | ',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Text(
                            '${widget.paymentCompleteCount}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2F4F4F)),
                          ),
                          Text('건'),
                        ],
                      )),
                  SizedBox(width: 50.0),
                  SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          SizedBox(
                              width: 40,
                              child: Text('취소 | ', textAlign: TextAlign.start)),
                          Text('${widget.cancelCount}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepOrangeAccent)),
                          Text('건'),
                        ],
                      )),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child:
                              Text('배송중      | ', textAlign: TextAlign.start),
                        ),
                        Text(
                          '${widget.deliveringCount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFDAA520)),
                        ),
                        Text('건'),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text('교환 | ', textAlign: TextAlign.start),
                        ),
                        Text(
                          '${widget.exchangeCount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo),
                        ),
                        Text('건'),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          child:
                          Text('배송 완료 | ', textAlign: TextAlign.start),
                        ),
                        Text(
                          '${widget.deliveredCount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        Text('건'),
                      ],
                    ),
                  ),
                  SizedBox(width: 50.0),
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: Text('환불 | ', textAlign: TextAlign.start),
                        ),
                        Text(
                          '${widget.refundCount}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        Text('건'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
