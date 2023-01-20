import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../api/spring_review_api.dart';

class MyFavoriteProductCard extends StatefulWidget {
  const MyFavoriteProductCard(
      {Key? key,
      required this.productNo,
      required this.price,
      required this.image,
      required this.title,
      required this.nickname,
      required this.press})
      : super(key: key);

  final int productNo, price;
  final String image, title, nickname;

  final VoidCallback press;

  @override
  State<MyFavoriteProductCard> createState() => _MyFavoriteProductCardState();
}

class _MyFavoriteProductCardState extends State<MyFavoriteProductCard> {
  var f = NumberFormat('###,###,###,###');
  double starRate = 0.0;
  int reviewCount = 0;

  @override
  void initState() {
    super.initState();

    _getStarRateAndReviewCount();
  }

  _getStarRateAndReviewCount() async {
    double getStarRate = await SpringReviewApi().averageOfStarRating(widget.productNo);
    int getReviewCount = await SpringReviewApi().reviewCount(widget.productNo);

    setState(() {
      starRate = getStarRate;
      reviewCount = getReviewCount;
    });
  }


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
                    child: Stack(
                      children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                AssetImage('assets/product/${widget.image}')),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                        Container(
                          width: 180,
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar
                              (radius: 20,
                              backgroundColor: Colors.black.withOpacity(0.2)),
                          ),
                        ),
                        Container(
                          width: 180,
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Icon(Icons.lightbulb, size: 40, color: Color(0xFFffc81c),),
                          ),
                        )
                      ]
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
                                    '$starRate',
                                    style: TextStyle(
                                        fontSize: 12, fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                      child: Text(
                                        "($reviewCount)",
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
