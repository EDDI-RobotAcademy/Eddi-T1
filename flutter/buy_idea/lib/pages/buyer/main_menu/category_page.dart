import 'package:buy_idea/pages/buyer/category/handmade_page.dart';
import 'package:buy_idea/pages/buyer/category/hobby_page.dart';
import 'package:buy_idea/pages/buyer/category/knowhow_page.dart';
import 'package:buy_idea/utility/size.dart';
import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/top_bar.dart';
import '../../../component/buyer/category/category_card.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
     {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopBar(),
        body: Center(
          child: Column(
            children: [
                CategoryCard(
                  title: '핸드메이드',
                  subTitle: '빛나는 아이디어로 만들어낸\n다양한 핸드메이드 작품',
                    cardImage: AssetImage("assets/category/handmade_icon.png"),
                  onCustomButtonPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const HandmadePage()));
                  },
              ),
              SizedBox(height: large_gap),
              CategoryCard(
                  title: '직업 노하우',
                  subTitle: '전문가가 필요한 순간!\n서점엔 없는 내 직업의 노하우',
                  cardImage: AssetImage("assets/category/knowhow_icon.png"),
                onCustomButtonPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const KnowhowPage()));
                },
              ),
              const SizedBox(height: large_gap),
              CategoryCard(
                  title: '취미/특기',
                  subTitle: '직접 체험하고 경험하는\nDIY·공방·Class',
                  cardImage: AssetImage("assets/category/hobby_icon.png"),
                onCustomButtonPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const HobbyPage()));
                },
              ),
            ],
          ),
        ));
  }
}
