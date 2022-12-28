import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CategoryProductCard extends StatefulWidget {
  const CategoryProductCard(
      {Key? key,
      required this.productNo,
      required this.image,
      required this.title,
      required this.nickname,
      required this.price,
      // required this.starRate,
      // required this.reviewCount,
      required this.press})
      : super(key: key);

  @override
  State<CategoryProductCard> createState() => _CategoryProductCardState();
  final int productNo, price;
  final String image, title, nickname;

  // final int starRate, reviewCount;
  final VoidCallback press;
}

class _CategoryProductCardState extends State<CategoryProductCard> {
  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: widget.press,
                    child: Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/product/${widget.image}')),
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                VerticalDivider(),
                SizedBox(height: 5),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.nickname,
                        style: TextStyle(fontSize: 10, color: Colors.grey)),
                    SizedBox(
                        height: 40,
                        child:
                            Text(widget.title, style: TextStyle(fontSize: 13))),
                    Divider(
                      thickness: 1,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        f.format(widget.price) + "원",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.star_rate,
                                color: Colors.amber,
                                size: 14,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '',
                                // widget.starRate,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                  child: Text(
                                '',
                                // "(" + widget.reviewCount + ")",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          )),
    );
  }
}
