import 'package:buy_idea/pages/buyer/main_menu/category_page.dart';
import 'package:buy_idea/pages/buyer/main_menu/search_page.dart';
import 'package:flutter/material.dart';

import '../../../pages/buyer/main_menu/home_page.dart';
import '../../../pages/buyer/my_info/my_info_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  ///맨 처음에 나오는 화면
  int _selectedIndex = 0;

  ///이동할 페이지 List
  static const List _pages = [
    HomePage(),
    CategoryPage(),
    SearchPage(),
    MyInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        iconSize: 30,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: "카테고리",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "검색",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "내 정보",
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // index는 item 순서로 0, 1, 2로 구성
    });
  }
}
