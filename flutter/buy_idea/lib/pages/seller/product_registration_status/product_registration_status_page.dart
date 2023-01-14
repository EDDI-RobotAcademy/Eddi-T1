import 'package:buy_idea/component/seller/product_registration_status/product_registration_status_list.dart';
import 'package:flutter/material.dart';

class ProductRegistrationStatusPage extends StatefulWidget {
  const ProductRegistrationStatusPage({Key? key, this.nickname}) : super(key: key);

  final String? nickname;

  @override
  State<ProductRegistrationStatusPage> createState() => _ProductRegistrationStatusPageState();
}

class _ProductRegistrationStatusPageState extends State<ProductRegistrationStatusPage> with TickerProviderStateMixin {

  late TabController tabController;

  final String _handmade = "핸드메이드";
  final String _knowhow = "노하우";
  final String _hobby = "취미/특기";

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  Widget _tabMenu(String menu) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
          menu,
          style: TextStyle(fontSize: 13, color: Colors.black)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('${widget.nickname} 상품 등록 현황', style: TextStyle(color: Colors.black, fontSize: 15)),
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            height: AppBar().preferredSize.height,
            decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Colors.grey),
                  top: BorderSide(color: Colors.grey, width: 0.1)
              )
            ),
            child: TabBar(
                controller: tabController,
                indicatorColor: const Color(0xff2F4F4F),
                tabs: [
                  _tabMenu('핸드메이드'),
                  _tabMenu('노하우'),
                  _tabMenu('취미/특기'),
                ],
            ),
          ),
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ProductRegistrationStatusList(seller: widget.nickname!, category: _handmade, listSize: 4, nextListSize: 4),
          ProductRegistrationStatusList(seller: widget.nickname!, category: _knowhow, listSize: 4, nextListSize: 4),
          ProductRegistrationStatusList(seller: widget.nickname!, category: _hobby, listSize: 4, nextListSize: 4),
        ],
      ),
    );
  }
}
