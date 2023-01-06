import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class SpringReviewApi {

  static const String httpUri = '192.168.0.12:8888';

  Future<bool> productReviewRegister(ProductReviewRegisterInfo productReviewRegisterInfo) async {

    Dio dio = Dio();

    final MultipartFile image = MultipartFile.fromFileSync(
        productReviewRegisterInfo.image.path,
      contentType: MediaType('image', 'jpg')
    );

    FormData formData = FormData.fromMap({
      'file' : image,
      'review' : MultipartFile.fromString(
        jsonEncode({
          'productNo' : productReviewRegisterInfo.productNo,
          'writer' : productReviewRegisterInfo.writer,
          'starRating' : productReviewRegisterInfo.starRating,
          'content' : productReviewRegisterInfo.content
        }),
        contentType: MediaType.parse('application/json')
      )
    });

    var response = await dio.post(
      'http://$httpUri/review/register',
      data: formData
    );

    if (response.statusCode == 200) {
      debugPrint('productReviewRegister() 통신 확인');
      return true;
    } else {
      throw Exception('productReviewRegister() 에러 발생');
    }
  }
}

class ProductReviewRegisterInfo {
  int productNo;
  String writer;
  int starRating;
  XFile image;
  String content;

  ProductReviewRegisterInfo(
    this.productNo,
    this.writer,
    this.starRating,
    this.image,
    this.content
  );
}