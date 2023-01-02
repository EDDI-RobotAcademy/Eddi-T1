import 'package:buy_idea/component/buyer/shopping_bucket/shopping_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TotalPriceBottom extends StatefulWidget {
  const TotalPriceBottom({Key? key}) : super(key: key);

  @override
  State<TotalPriceBottom> createState() => _TotalPriceBottomState();
}

class _TotalPriceBottomState extends State<TotalPriceBottom> {
  final shoppingController = Get.put(ShoppingController());
  var f = NumberFormat('###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16,
        bottom: 8.0,
        top: 4.0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "총 금액",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GetX<ShoppingController>(builder: (controller) {
                    return Text(
                      '${f.format((shoppingController.totalPrice).toInt())}원',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    );
                  }),
                  const Text(
                    "배송비 포함 금액입니다.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16.0,
                    ),
                    primary: const Color(0XFF2F4F4F),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: const BorderSide(
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("결제하기"),
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }
}
