import 'package:buy_idea/api/spring_shopping_bucket_api.dart';
import 'package:buy_idea/pages/account/sign_in_page.dart';
import 'package:buy_idea/pages/buyer/order/order_page.dart';
import 'package:buy_idea/pages/buyer/shopping_bucket/shopping_bucket_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/yes_or_no_alert_dialog.dart';
import '../shopping_bucket/shopping_controller.dart';

class ProductBuyAndShoppingCartSelectModalSheet extends StatefulWidget {
  final String seller;
  final String productTitle;
  final int productPrice;
  final int deliveryFee;
  final int freeDeliveryFee;
  final int stock;
  final int productNo;

  const ProductBuyAndShoppingCartSelectModalSheet(
      {Key? key,
      required this.seller,
      required this.productTitle,
      required this.productPrice,
      required this.deliveryFee,
      required this.freeDeliveryFee,
      required this.stock,
      required this.productNo})
      : super(key: key);

  @override
  State<ProductBuyAndShoppingCartSelectModalSheet> createState() =>
      _ProductBuyAndShoppingCartSelectModalSheetState();
}

class _ProductBuyAndShoppingCartSelectModalSheetState
    extends State<ProductBuyAndShoppingCartSelectModalSheet> {
  final shoppingController = Get.put(ShoppingController());
  int purchaseQuantity = 1;

  static const storage = FlutterSecureStorage();
  dynamic memberInfo = '';
  dynamic memberNickname = '';

  // 상품 금액이 숫자 세자리 넘어갈 때마다 콤마를 넣기 위한 intl 라이브러리를 통한 포맷 변수 초기화
  var f = NumberFormat('###,###,###,###');

  // 상품 수량 카운트 버튼 커스텀 위젯
  Widget CountButton(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                if (purchaseQuantity > 1) {
                  setState(() {
                    purchaseQuantity--;
                  });
                } else {
                  // 사용자가 상품 수량이 1미만으로 설정하려고 할 시 띄워지는 alert dialog
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 20,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          content: Text(
                            '더이상 수량을 줄일 수 없습니다!',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('확인',
                                    style: TextStyle(color: Color(0xff2F4F4F))))
                          ],
                        );
                      });
                }
              },
              child: Icon(Icons.remove),
            ),
            Expanded(
                child: Text(
              '$purchaseQuantity',
              textAlign: TextAlign.center,
            )),
            InkWell(
              onTap: () {
                if (purchaseQuantity < widget.stock) {
                  setState(() {
                    purchaseQuantity++;
                  });
                } else {
                  showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 20,
                          backgroundColor: Colors.white.withOpacity(0.8),
                          content: Text(
                            '남은 수량을 초과할 수 없습니다!',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text('확인',
                                    style: TextStyle(color: Color(0xff2F4F4F))))
                          ],
                        );
                      });
                }
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }

  // 무료배송 조건을 만족하지 못했을 때 배송비 및 무료배송 조건금액 명시
  Widget NotFreeShippingCost() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('배송비 ${f.format(widget.deliveryFee)}원',
            style: TextStyle(fontSize: 12)),
        SizedBox(height: 5),
        Text(
          '(${f.format(widget.freeDeliveryFee)}원 이상 구매 시 무료배송)',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }

  // 무료배송 조건을 만족했을 때 무료배송 명시
  Widget FreeShippingCost() {
    return Text('무료배송',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold));
  }

  bool checkSignIn() {
    if (memberInfo != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    memberInfo = await storage.read(key: 'userToken');
    memberNickname = await storage.read(key: 'nickname');
    setState(() {
      memberInfo = memberInfo;
      memberNickname = memberNickname;
    });
  }

  _addShoppingBucketProducts() async {
    ShoppingBucketRequest shoppingBucketRequest = ShoppingBucketRequest(
        widget.productNo, memberNickname, purchaseQuantity);
    debugPrint('shoppingBucketRequest : ' + shoppingBucketRequest.toString());
    await SpringShoppingBucketApi()
        .shoppingBucketRegister(shoppingBucketRequest);

    if (SpringShoppingBucketApi.bucketRegisterResponse.statusCode == 200) {
      _accountDeleteShowDialog();
    } else {
      throw Exception('productDetailsInfo() 에러 발생');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        child: Column(
          children: [
            Container(
              height: 5,
              width: 40,
              margin: EdgeInsets.only(top: 10, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(20)),
            ),
            Center(
              child: Text('상품 구매 방식 선택', style: TextStyle(fontSize: 14)),
            ),
            Divider(thickness: 0.8, height: 15),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage('assets/default_profile_image.png'),
                          ),
                          SizedBox(width: 10),
                          Text(widget.seller)
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.productTitle,
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.start,
                      )
                    ],
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 10),
                  Expanded(
                      child: Text('남은 수량 ${f.format(widget.stock)}개',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold))),
                  CountButton(150, 40),
                  SizedBox(width: 10)
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.black, width: 0.2)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        widget.freeDeliveryFee >
                                widget.productPrice * purchaseQuantity
                            ? NotFreeShippingCost()
                            : FreeShippingCost(),
                        Expanded(child: SizedBox()),
                        Text('총 상품금액', style: TextStyle(fontSize: 12)),
                        SizedBox(width: 5),
                        Text(
                            '${f.format(widget.productPrice * purchaseQuantity)}원',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16))
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.white,
                              side: BorderSide(color: Colors.black26),
                              fixedSize: Size(190, 30)),
                          onPressed: () {
                            if (checkSignIn()) {
                              _addShoppingBucketProducts();
                              // TODO: 장바구니에 상품을 담고 장바구니 페이지로 이동할지 말지 선택하는 다이얼로그 띄우는 로직
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      elevation: 20,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.8),
                                      content: Text(
                                        '장바구니를 이용하기 위해서 로그인이 필요합니다!',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.off(SignInPage());
                                            },
                                            child: Text('로그인',
                                                style: TextStyle(
                                                    color: Color(0xff2F4F4F)))),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('취소',
                                                style: TextStyle(
                                                    color: Color(0xff2F4F4F))))
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Text('장바구니',
                              style: TextStyle(color: Color(0xffDAA520)))),
                      SizedBox(width: 5),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Color(0xff2F4F4F),
                              fixedSize: Size(190, 30)),
                          onPressed: () {
                            if (checkSignIn()) {
                              List<int> productNoList = [widget.productNo];
                              List<int> purchaseQuantityList = [
                                purchaseQuantity
                              ];
                              Get.off(OrderPage(
                                  productNoList: productNoList,
                                  purchaseQuantityList: purchaseQuantityList,
                                  bucketItemIdList:
                                      shoppingController.bucketItemIdList));
                            } else {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      elevation: 20,
                                      backgroundColor:
                                          Colors.white.withOpacity(0.8),
                                      content: Text(
                                        '구매하기 위해서 로그인이 필요합니다!',
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Get.off(SignInPage());
                                            },
                                            child: Text('로그인',
                                                style: TextStyle(
                                                    color: Color(0xff2F4F4F)))),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: Text('취소',
                                                style: TextStyle(
                                                    color: Color(0xff2F4F4F))))
                                      ],
                                    );
                                  });
                            }
                          },
                          child: Text('구매하기',
                              style: TextStyle(color: Colors.white))),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }

  /// 장바구니 등록 안내 alertDialog
  void _accountDeleteShowDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return YesOrNoAlertDialog(
            title: '🎁',
            content: '장바구니에 상품이 등록되었습니다.\n'
                '장바구니 페이지로 이동하시겠습니까?',
            yesButtonPressed: () {
              Get.off(const ShoppingBucketPage());
            },
            noButtonPressed: () {
              Get.back();
            },
          );
        });
  }
}
