import 'package:buy_idea/api/seller/spring_seller_total_api.dart';
import 'package:buy_idea/component/seller/app_bar/seller_common_app_bar.dart';
import 'package:buy_idea/component/seller/home/total_sales_form.dart';
import 'package:buy_idea/component/seller/home/total_status_card.dart';
import 'package:buy_idea/pages/seller/order_management/order_management_page.dart';
import 'package:buy_idea/pages/seller/product_registration_status/product_registration_status_page.dart';
import 'package:buy_idea/pages/seller/qna_management/qna_management_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../component/seller/app_bar/seller_drawer.dart';

class SellerMainPage extends StatefulWidget {
  const SellerMainPage({Key? key}) : super(key: key);
  static dynamic sellerId = '';
  static dynamic sellerNickname = '';
  static dynamic memberType = '';
  static dynamic userToken ='';

  @override
  State<SellerMainPage> createState() => _SellerMainPageState();
}

class _SellerMainPageState extends State<SellerMainPage> {

  static const storage = FlutterSecureStorage();

  bool loading = false;

  getSellerInfo() async{
    var getId = await storage.read(key: 'memberId');
    var getNickname = await storage.read(key: 'nickname');
    var getMemberType = await storage.read(key: 'memberType');
    var getUserToken = await storage.read(key: 'userToken');
    setState(() {
      SellerMainPage.sellerId = getId;
      SellerMainPage.sellerNickname = getNickname;
      SellerMainPage.memberType = getMemberType;
      SellerMainPage.userToken = getUserToken;
      loading = true;
    });
    await getTotal(SellerMainPage.sellerNickname);
  }

  bool totalLoading = false;

  TotalInfo totalInfo = TotalInfo(totalProduct: 0, totalReview: 0, totalQnA: 0, totalOrder: 0, totalSales: 0);

  getTotal(String seller) async {
    totalInfo = await SpringSellerTotalApi().requestTotalInfoOfSeller(seller);
    setState(() {
      totalInfo;
      totalLoading = true;
    });
  }

  PageController pageController = PageController(viewportFraction: 0.8);

  @override
  void initState() {
    getSellerInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(loading == true && totalLoading == true){
      return Scaffold(
          drawer: SellerDrawer(nickname: SellerMainPage.sellerNickname),
          appBar: SellerCommonAppBar(
            title: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerMainPage()));
              },
              child: Image.asset('assets/buydia_logo.png', width: 100),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '나의 현황\n한 눈에 보기',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: [
                      TotalStatusCard(
                        total: totalInfo.totalProduct,
                        title: '상품 현황',
                        subTitle: '나만의 아이디어로 탄생한 상품!\n',
                        imageName: 'assets/seller_main/my_posts.png',
                        bottomText: '등록한 상품',
                        countText: '개',
                        onTap: () {
                          Get.offAll(ProductRegistrationStatusPage(nickname: SellerMainPage.sellerNickname));
                        },
                      ),
                      TotalStatusCard(
                        total: totalInfo.totalReview,
                        title: '구매 후기 현황',
                        subTitle: '\' 마음에 쏙 들어요 💕 \'\n\' 너무 좋아요 😊 \'',
                        imageName: 'assets/seller_main/reviews.png',
                        bottomText: '구매 후기',
                        countText: '개',
                        onTap: () {
                          Get.offAll(ProductRegistrationStatusPage(nickname: SellerMainPage.sellerNickname));
                        },
                      ),
                      TotalStatusCard(
                        total: totalInfo.totalQnA,
                        title: '문의 현황',
                        subTitle: '궁금한게 너무나 많아요!\n혹시.. 판매자님은 천재이신가요?! 🤔',
                        imageName: 'assets/seller_main/questions.png',
                        bottomText: '답변 대기 문의',
                        countText: '개',
                        onTap: () {
                          Get.offAll(QnaManagementPage());
                        },
                      ),
                      TotalStatusCard(
                        total: totalInfo.totalOrder,
                        title: '주문 현황',
                        subTitle: '불티나게 팔리는 나의 아이디어!\n확인하러 가볼까요? 😆',
                        imageName: 'assets/seller_main/mobile_payments.png',
                        bottomText: '모든 주문',
                        countText: '건',
                        onTap: () {
                          Get.offAll(OrderManagementPage());
                        },
                      ),
                    ],
                  ),
                ),
                SmoothPageIndicator(
                  controller: pageController,
                  count: 4,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Color(0xff2F4F4F)
                  ),
                ),
                SizedBox(height: 50),
                TotalSalesForm(sales: totalInfo.totalSales),
                SizedBox(height: 20),
              ],
            ),
          )
      );
    } else {
      return Container(
        color: Colors.white,
        child: const Center(
          child: Image(
            image: AssetImage('assets/buydia_animation_logo.gif'),
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }
}
