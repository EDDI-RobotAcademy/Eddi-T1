import 'package:flutter/material.dart';

class Product {
  final String image, title;
  final Color bgColor;

  Product({
    required this.image,
    required this.title,
    this.bgColor = const Color(0xFFEFEFF2),
  });
}

List<Product> handmade_list = [
  Product(
    image: "assets/product/handmade1.jpg",
    title: "선물추천♡볼통통한 토끼 볼토 키링",
    bgColor: const Color(0xFFFEFBF9),
  ),
  Product(
    image: "assets/product/handmade2.jpg",
    title: "⭐️2주소요⭐️ 뜨개 호보백 (61 colors)",
  ),
  Product(
    image: "assets/product/handmade3.jpg",
    title: "✨하트 앨리스 키링✨ (핸드폰 줄 변경 가능👌)",
    bgColor: const Color(0xFFF8FEFB),
  ),
  Product(
    image: "assets/product/handmade4.jpg",
    title: "겨울 크리스마스 캔들 모음전 | 트리 산타 눈사람 털실",
    bgColor: const Color(0xFFEEEEED),
  ),
];

List<Product> knowhow_list = [
  Product(
    image: "assets/product/knowhow1.jpg",
    title: "계좌공개 실전매매 스켈핑 방법!",
    bgColor: const Color(0xFFFEFBF9),
  ),
  Product(
    image: "assets/product/knowhow2.jpg",
    title: "급등주보다 매일챙기는 매매법",
  ),
  Product(
    image: "assets/product/knowhow3.jpg",
    title: "15년 무손실 종목검색식 공개",
    bgColor: const Color(0xFFF8FEFB),
  ),
  Product(
    image: "assets/product/knowhow4.jpg",
    title: "8년차 마케터의 오토수익화 시스템",
    bgColor: const Color(0xFFEEEEED),
  ),
];

List<Product> hobby_list = [
  Product(
    image: "assets/product/hobby1.jpg",
    title: "재봉틀 수업",
    bgColor: const Color(0xFFFEFBF9),
  ),
  Product(
    image: "assets/product/hobby2.jpg",
    title: "십자수 수업",
  ),
  Product(
    image: "assets/product/hobby3.jpg",
    title: "에그타르트 만들기",
    bgColor: const Color(0xFFF8FEFB),
  ),
  Product(
    image: "assets/product/hobby4.jpg",
    title: "머랭쿠키 만들기",
    bgColor: const Color(0xFFEEEEED),
  ),
];