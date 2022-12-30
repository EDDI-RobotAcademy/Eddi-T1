import 'package:buy_idea/api/spring_product_api.dart';
import 'package:buy_idea/component/buyer/app_bar/title_top_bar.dart';
import 'package:buy_idea/component/buyer/order/delivery_address_input_form.dart';
import 'package:buy_idea/component/buyer/order/ordering_customer_info_form.dart';
import 'package:buy_idea/component/buyer/order/ordering_info_form.dart';
import 'package:flutter/material.dart';

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

  var future;

  List<RequestProduct> products = [];
  List<RequestProductImage> productImages = [];

  Future<void> _loadProducts() async {
    for(var i = 0; i < widget.productNoList.length; i++) {
      products.add(await SpringProductApi().productDetailsInfo(widget.productNoList[i]));
      productImages.add(await SpringProductApi().productThumbnailImage(widget.productNoList[i]));
    }
  }

  @override
  void initState() {
    future = _loadProducts();
    super.initState();
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
                      SizedBox(height: 80)
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
