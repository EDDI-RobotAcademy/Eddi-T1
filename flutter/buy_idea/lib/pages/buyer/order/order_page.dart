import 'package:buy_idea/api/spring_order_api.dart';
import 'package:buy_idea/api/spring_product_api.dart';
import 'package:buy_idea/component/buyer/app_bar/title_top_bar.dart';
import 'package:buy_idea/component/buyer/order/delivery_address_input_form.dart';
import 'package:buy_idea/component/buyer/order/ordering_customer_info_form.dart';
import 'package:buy_idea/component/buyer/order/ordering_info_form.dart';
import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/user.dart';
import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  final List<int> productNoList;
  final List<int> purchaseQuantityList;

  const OrderPage({
    Key? key,
    required this.productNoList,
    required this.purchaseQuantityList
  }) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController addressDetailController = TextEditingController();

  static const storage = FlutterSecureStorage();
  dynamic buyer = '';

  var f = NumberFormat('###,###,###,###');

  var future;

  List<RequestProduct> products = [];
  List<RequestProductImage> productImages = [];

  Future<void> _loadProducts() async {
    for(var i = 0; i < widget.productNoList.length; i++) {
      products.add(await SpringProductApi().productDetailsInfo(widget.productNoList[i]));
      productImages.add(await SpringProductApi().productThumbnailImage(widget.productNoList[i]));
    }
  }

  String webApplicationId = '63a16493cf9f6d001ed120aa';
  String androidApplicationId = '63a16493cf9f6d001ed120ab';
  String iosApplicationId = '63a16493cf9f6d001ed120ac';

  @override
  void initState() {
    future = _loadProducts();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    buyer = await storage.read(key: 'nickname');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // 메소드가 완료되지 않았다면 로딩표시 애니메이션을 화면에 띄움
          return Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff2F4F4F),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: TitleTopBar(titleText: '상품 결제'),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                  child: Column(
                    children: [
                      OrderingCustomerInfoForm(),
                      SizedBox(height: 10),
                      DeliveryAddressInputForm(
                        recipientController: recipientController,
                        phoneController: phoneController,
                        zipcodeController: zipcodeController,
                        cityController: cityController,
                        streetController: streetController,
                        addressDetailController: addressDetailController,
                      ),
                      SizedBox(height: 10),
                      OrderingInfoForm(products: products, productImages: productImages, purchaseQuantityList: widget.purchaseQuantityList),
                      SizedBox(height: 90)
                    ],
                  ),
                ),
              ),
            ),
            bottomSheet: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (recipientController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          zipcodeController.text.isNotEmpty &&
                          cityController.text.isNotEmpty &&
                          streetController.text.isNotEmpty &&
                          addressDetailController.text.isNotEmpty) {
                        bootpayTest(context);
                      } else {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text('입력사항들을 전부 기입해주세요.'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('확인')
                                  )
                                ],
                              );
                            }
                        );
                      }
                    },
                    child: Text('${f.format(_getProductTotalPrice() + _getTotalDeliveryFee())}원 결제하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(MediaQuery.of(context).size.width - 20, 60),
                        primary: Color(0xff2F4F4F)
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void bootpayTest(BuildContext context) {
    Payload payload = getPayload();
    if(kIsWeb) {
      payload.extra?.openType = "iframe";
    }


    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel: $data');
      },
      onError: (String data) {
        print('------- onError: $data');
      },
      onClose: () {
        print('------- onClose');
        Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        //TODO - 원하시는 라우터로 페이지 이동
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        /**
            1. 바로 승인하고자 할 때
            return true;
         **/
        /***
            2. 클라이언트 승인 하고자 할 때
            Bootpay().transactionConfirm();
            return false;
         ***/
        /***
            3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
            return false; 후에 서버에서 결제승인 수행
         */
        Bootpay().transactionConfirm();
        return false;
      },
      onDone: (String data) {
        print('------- onDone: $data');
        int i = 0;
        List<OrderInfo> orderInfoList = [];
        AddressInfo addressInfo = AddressInfo(
            recipientController.text,
            phoneController.text,
            zipcodeController.text,
            cityController.text,
            streetController.text,
            addressDetailController.text
        );
        for (RequestProduct product in products) {
          orderInfoList.add(
              OrderInfo(
                  buyer,
                  product.nickname,
                  product.title,
                  widget.purchaseQuantityList[i],
                  product.price * widget.purchaseQuantityList[i],
                  "입금 완료"
              )
          );
          i++;
        }
        SpringOrderApi().orderRegister(orderInfoList, addressInfo);
        Get.offAll(MainPage());
      },
    );
  }

  Payload getPayload() {
    Payload payload = Payload();

    payload.webApplicationId = webApplicationId; // web application id
    payload.androidApplicationId = androidApplicationId; // android application id
    payload.iosApplicationId = iosApplicationId; // ios application id


    payload.pg = '이니시스';
    payload.method = '카드';
    payload.orderName = _getProductTitle(products); //결제할 상품명
    payload.price = 100; //정기결제시 0 혹은 주석

    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString(); //주문번호, 개발사에서 고유값으로 지정해야함

    User user = User(); // 구매자 정보
    user.username = "사용자 이름";
    user.email = "user1234@gmail.com";
    user.area = "서울";
    user.phone = "010-0000-000";
    user.addr = '서울시 동작구 상도로 222';

    Extra extra = Extra(); // 결제 옵션
    extra.appScheme = 'bootpayFlutterExample';
    extra.cardQuota = '3';
    extra.openType = 'popup';
    extra.displaySuccessResult = true;

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

    payload.user = user;
    payload.extra = extra;
    return payload;
  }

  int _getProductTotalPrice() {
    int total = 0;
    for(int i = 0; i < products.length; i++) {
      total += products[i].price * widget.purchaseQuantityList[i];
    }
    return total;
  }

  _getTotalDeliveryFee() {
    int total = 0;
    for (int i = 0; i < products.length; i++) {
      if (products[i].price * widget.purchaseQuantityList[i] < 50000) {
        total += products[i].deliveryFee;
      }
    }
    return total;
  }

  String _getProductTitle(List<RequestProduct> products) {
    if (products.length < 2) {
      return products[0].title;
    } else {
      return '${products[0].title} 외 ${products.length - 1}건';
    }
  }
}
