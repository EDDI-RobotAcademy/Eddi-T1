import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final AssetImage cardImage;
  final VoidCallback onCustomButtonPressed;

  const CategoryCard(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.cardImage, required this.onCustomButtonPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200.0,
        width: 360.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                blurRadius: 5.0,
                spreadRadius: 0.0,
                offset: const Offset(0, 7),
              )
            ]),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 50.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  subTitle,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 10.0, top: 20.0, bottom: 10),
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    image:
                        DecorationImage(image: cardImage, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                onCustomButtonPressed.call();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 120.0, left: 20.0),
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white,
                      border: Border.all(width: 1,
                      color: Colors.black)
                    ),
                    child: const Icon(
                      Icons.arrow_right_alt_outlined,
                      size: 40.0,
                      color: Colors.black,
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
