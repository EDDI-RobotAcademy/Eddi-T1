import 'package:buy_idea/component/seller/seller_common_app_bar.dart';
import 'package:buy_idea/component/seller/seller_drawer.dart';
import 'package:buy_idea/pages/seller/my_info/seller_my_info_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SellerMainPage extends StatefulWidget {
  const SellerMainPage({Key? key}) : super(key: key);

  @override
  State<SellerMainPage> createState() => _SellerMainPageState();
}

class _SellerMainPageState extends State<SellerMainPage> {
  static const storage = FlutterSecureStorage();
  dynamic memberNickname = '';

  int _selectedPageIndex = 0;

  List _pages = [
    Center(child: Text('주문 관리 페이지')),
    SellerMyInfoPage()
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    memberNickname = await storage.read(key: 'nickname');
    setState(() {
      memberNickname = memberNickname;
    });
    debugPrint(memberNickname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SellerDrawer(nickname: memberNickname),
      appBar: SellerCommonAppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerMainPage()));
          },
          child: Image.asset('assets/buydia_logo.png', width: 100),
        ),
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white10,
            border: Border(top: BorderSide(color: Colors.grey, width: 0.3))
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.inventory_outlined), label: '주문 관리'),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined), label: '내 정보')
          ],
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
}
