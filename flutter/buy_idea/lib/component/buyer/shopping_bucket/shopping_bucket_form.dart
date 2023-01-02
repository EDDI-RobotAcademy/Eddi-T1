import 'package:buy_idea/component/buyer/shopping_bucket/shopping_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/common_alert_dialog.dart';

class ShoppingBucketForm extends StatefulWidget {
  const ShoppingBucketForm({Key? key}) : super(key: key);

  @override
  State<ShoppingBucketForm> createState() => _ShoppingBucketFormState();
}

class _ShoppingBucketFormState extends State<ShoppingBucketForm> {
  final shoppingController = Get.put(ShoppingController());

  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetX<ShoppingController>(builder: (controller) {
        if (controller.loading.value) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0XFF2F4F4F)));
        }
        if (controller.bucketProducts.isEmpty) {
          return const Center(child: Text("No cart items found!"));
        } else {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: controller.bucketProducts.length,
            padding: EdgeInsets.all(8),
            itemBuilder: (context, index) => Card(
              elevation: 0,
              child: Container(
                height: 240,
                padding: const EdgeInsets.all(8.0),
                width: 100,
                margin: EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Icon(Icons.cancel_outlined),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                      'assets/product/${shoppingController.bucketProducts[index].image}')),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: 150.0,
                                          child: Text(
                                            shoppingController
                                                .bucketProducts[index].title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150.0,
                                          child: Text(
                                            shoppingController
                                                .bucketProducts[index].nickname,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                            maxLines: 1,
                                            textAlign: TextAlign.start,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (shoppingController
                                                    .bucketProducts[index]
                                                    .itemCount <=
                                                1) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CommonAlertDialog(
                                                      title: "⚠️",
                                                      content:
                                                          '더 이상 수량을 줄일 수 없습니다.',
                                                      onCustomButtonPressed:
                                                          () {
                                                        Get.back();
                                                      },
                                                    );
                                                  });
                                            } else {
                                              shoppingController
                                                  .removeToItemPrice(
                                                      controller.bucketProducts[
                                                          index],
                                                      index);
                                            }
                                            if (shoppingController
                                                        .bucketProducts[index]
                                                        .price *
                                                    shoppingController
                                                        .bucketProducts[index]
                                                        .itemCount >=
                                                50000) {
                                              shoppingController
                                                  .deliveryFeeFree(
                                                      controller.bucketProducts[
                                                          index],
                                                      index);
                                            } else if (shoppingController
                                                        .bucketProducts[index]
                                                        .price *
                                                    shoppingController
                                                        .bucketProducts[index]
                                                        .itemCount <
                                                50000) {
                                              shoppingController.addDeliveryFee(
                                                  controller
                                                      .bucketProducts[index],
                                                  index);
                                            }
                                          },
                                          child: Container(
                                            color: Colors.grey[200],
                                            child: Icon(Icons.remove),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(8.0),
                                            child: GetX<ShoppingController>(
                                                builder: (controller) {
                                              return Text(
                                                  '${shoppingController.bucketProducts[index].itemCount}');
                                            })),
                                        InkWell(
                                          onTap: () {
                                            if (shoppingController
                                                    .bucketProducts[index]
                                                    .stock <=
                                                shoppingController
                                                    .bucketProducts[index]
                                                    .itemCount) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CommonAlertDialog(
                                                      title: "⚠️",
                                                      content:
                                                          '남은 수량을 초과할 수 없습니다.',
                                                      onCustomButtonPressed:
                                                          () {
                                                        Get.back();
                                                      },
                                                    );
                                                  });
                                            } else {
                                              shoppingController.addToItemPrice(
                                                  controller
                                                      .bucketProducts[index],
                                                  index);
                                            }
                                            if (shoppingController
                                                        .bucketProducts[index]
                                                        .price *
                                                    shoppingController
                                                        .bucketProducts[index]
                                                        .itemCount >=
                                                50000) {
                                              shoppingController
                                                  .deliveryFeeFree(
                                                      controller.bucketProducts[
                                                          index],
                                                      index);
                                            } else if (shoppingController
                                                        .bucketProducts[index]
                                                        .price *
                                                    shoppingController
                                                        .bucketProducts[index]
                                                        .itemCount <
                                                50000) {
                                              shoppingController.addDeliveryFee(
                                                  controller
                                                      .bucketProducts[index],
                                                  index);
                                            }
                                          },
                                          child: Container(
                                            color: Colors.grey[200],
                                            child: Icon(Icons.add),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: [
                                    const Text(
                                      '금액',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    Expanded(
                                        child: Container(
                                            height: 1.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.grey[200])),
                                    const SizedBox(width: 5.0),
                                    Text(
                                      '${f.format(shoppingController.bucketProducts[index].price)}원',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      '배송비',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5.0),
                                    Expanded(
                                        child: Container(
                                            height: 1.0,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.grey[200])),
                                    SizedBox(width: 5.0),
                                    Text(
                                      '${f.format(shoppingController.bucketProducts[index].deliveryFee)}원',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      color: Colors.grey[200],
                      width: MediaQuery.of(context).size.width,
                      height: 70.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                        GetX<ShoppingController>(builder: (controller) {
                          return Text(
                            '상품 총 금액 : ${f.format(shoppingController.bucketProducts[index].price * shoppingController.bucketProducts[index].itemCount)}원',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          );
                        }),
                        GetX<ShoppingController>(builder: (controller) {
                          return Text(
                              '배송비 : ${f.format(shoppingController.bucketProducts[index].sumDeliveryFee)}원',
                              style: TextStyle(
                                  fontSize: 16));
                        }),
                      ]),
                    )
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
