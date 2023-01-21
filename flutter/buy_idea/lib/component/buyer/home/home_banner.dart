import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../utility/size.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({Key? key}) : super(key: key);

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  List<String> imagesList = [
    "assets/main_banner/main_banner1.jpg",
    "assets/main_banner/main_banner2.jpg",
    "assets/main_banner/main_banner3.jpg",
    "assets/main_banner/main_banner4.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: xxlarge_gap,
        enlargeCenterPage: true,
        autoPlay: true,
        onPageChanged: (position, reason) {
        },
        enableInfiniteScroll: false,
      ),
      items: imagesList.map<Widget>((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(image: DecorationImage(image: AssetImage(i))),
            );
          },
        );
      }).toList(),
    );
  }
}
