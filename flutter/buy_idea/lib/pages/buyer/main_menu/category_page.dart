import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/top_bar.dart';


class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    //vsync에 this형태로 전달해야 애니메이션이 정상 처리됨
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: TopBar(),
        body: Column(
          children: [
            Container(
              height: size.height * 0.07,
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(width: 1, color: Colors.grey))),
              child: TabBar(
                controller: _tabController,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.black,
                indicatorColor: Colors.teal,
                tabs: [
                  Tab(text: '핸드메이드'),
                  Tab(text: '직업 노하우'),
                  Tab(text: '취미 & 특기'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(
                      color: Colors.yellow[200],
                      alignment: Alignment.center,
                      child: Text(
                        'Tab1 View',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )),
                  Container(
                      color: Colors.green[200],
                      alignment: Alignment.center,
                      child: Text(
                        'Tab2 View',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )),
                  Container(
                      color: Colors.blue[200],
                      alignment: Alignment.center,
                      child: Text(
                        'Tab3 View',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
