import 'package:buy_idea/api/spring_product_api.dart';
import 'package:flutter/material.dart';

class ProductDetailsPageImageView extends StatefulWidget {
  final List<RequestProductImage> imageList;

  const ProductDetailsPageImageView({
    Key? key,
    required this.imageList
  }) : super(key: key);

  @override
  State<ProductDetailsPageImageView> createState() => _ProductDetailsPageImageViewState();
}

class _ProductDetailsPageImageViewState extends State<ProductDetailsPageImageView> {

  PageController _pageController = PageController();

  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: PageView.builder(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPageIndex = page;
                });
                print(_currentPageIndex);
              },
              itemCount: widget.imageList.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Image.asset('assets/product/${widget.imageList[index].editedName}', fit: BoxFit.cover)
                );
              }
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageList.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _pageController.jumpToPage(index);
                        });
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          border: _currentPageIndex == index ? Border.all(color: Color(0xffDAA520), width: 2) : null,
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: AssetImage('assets/product/${widget.imageList[index].editedName}'),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                    SizedBox(width: 5)
                  ],
                );
              }
            )
          ),
        ),
      ],
    );
  }
}
