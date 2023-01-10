import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

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

  Future<List<RequestProductReview>> productReviewList(int productNo, int reviewSize) async {

    var response = await http.get(
      Uri.http(httpUri, '/review/list', {'productNo' : productNo.toString(), 'reviewSize' : reviewSize.toString()}),
      headers: {'Content-Type' : 'application/json'}
    );

    if(response.statusCode == 200) {
      debugPrint("productReviewList() 통신 확인");
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<RequestProductReview> reviewList = data.map(
              (list) => RequestProductReview.fromJson(list)).toList();

      return reviewList;
    } else {
      throw Exception("productReviewList() 에러 발생");
    }
  }

  Future<List<RequestProductReview>> nextProductReviewList(int productNo, int reviewNo, int reviewSize) async {

    var response = await http.get(
        Uri.http(httpUri, '/review/next-list', {'productNo' : productNo.toString(), 'reviewNo' : reviewNo.toString(), 'reviewSize' : reviewSize.toString()}),
        headers: {'Content-Type' : 'application/json'}
    );

    if(response.statusCode == 200) {
      debugPrint("nextProductReviewList() 통신 확인");
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<RequestProductReview> reviewList = data.map(
              (list) => RequestProductReview.fromJson(list)).toList();

      return reviewList;
    } else {
      throw Exception("nextProductReviewList() 에러 발생");
    }
  }

  Future<RequestProductReviewImage> reviewImage(int reviewNo) async {

    var response = await http.get(
      Uri.http(httpUri, '/review/image/$reviewNo'),
      headers: {'Content-Type' : 'application/json'}
    );

    if(response.statusCode == 200) {
      debugPrint("reviewImage() 통신 확인");

      var data = jsonDecode(utf8.decode(response.bodyBytes));
      debugPrint("data : $data");
      RequestProductReviewImage reviewImage = RequestProductReviewImage.fromJson(data);
      debugPrint("reviewImage edited name : " + reviewImage.editedName);

      return reviewImage;
    } else {
      throw Exception("reviewImage() 에러 발생");
    }
  }

  Future<int> reviewCount(int productNo) async {

    var response = await http.get(
      Uri.http(httpUri, '/review/count/$productNo'),
      headers: {'Content-Type' : 'application/json'}
    );

    var data = int.parse(response.body);

    if(response.statusCode == 200) {
      debugPrint("reviewCount() 통신 확인");
      return data;
    } else {
      throw Exception("reviewCount() 에러 발생");
    }
  }

  Future<double> averageOfStarRating(int productNo) async {

    var response = await http.get(
        Uri.http(httpUri, '/review/star-rating/average/$productNo'),
        headers: {'Content-Type' : 'application/json'}
    );

    var data = double.parse(response.body);

    if(response.statusCode == 200) {
      debugPrint("averageOfStarRating() 통신 확인");
      return data;
    } else {
      throw Exception("averageOfStarRating() 에러 발생");
    }
  }

  Future<bool> productReviewModify(int reviewNo, int starRating, String content, XFile file) async {
    Dio dio = Dio();

    final MultipartFile image = MultipartFile.fromFileSync(
        file.path,
        contentType: MediaType('image', 'jpg')
    );

    FormData formData = FormData.fromMap({
      'file' : image,
      'review' : MultipartFile.fromString(
          jsonEncode({
            'reviewNo' : reviewNo,
            'starRating' : starRating,
            'content' : content
          }),
          contentType: MediaType.parse('application/json')
      )
    });

    var response = await dio.put(
        'http://$httpUri/review/modify',
        data: formData
    );

    if (response.statusCode == 200) {
      debugPrint("productReviewModify() 통신 확인");
      return true;
    } else {
      throw Exception("productReviewModify() 에러 발생");
    }
  }

  Future<bool> productReviewDelete(int reviewNo) async {

    var response = await http.delete(
      Uri.http(httpUri, '/review/delete/$reviewNo'),
      headers: {'Content-Type' : 'application/json'}
    );

    if (response.statusCode == 200) {
      debugPrint("productReviewDelete() 통신 확인");
      return true;
    } else {
      throw Exception("productReviewDelete() 에러 발생");
    }
  }

  Future<List<RequestMyReview>> myReviewList(String writer) async {

    var response = await http.get(
      Uri.http(httpUri, '/review/my-review/list/$writer'),
      headers: {'Content-Type' : 'application/json'}
    );

    if (response.statusCode == 200) {
      debugPrint("myReviewList() 통신 확인");
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;
      List<RequestMyReview> myReviewList = data.map((list) => RequestMyReview.fromJson(list)).toList();

      return myReviewList;
    } else {
      throw Exception("myReviewList() 에러 발생");
    }
  }

  Future<bool> checkWriteReview(String writer, int productNo) async {

    var response = await http.get(
      Uri.http(httpUri, '/review/check/write', {'writer' : writer, 'productNo' : productNo.toString()}),
      headers: {'Content-Type' : 'application/json'}
    );


    if (response.statusCode == 200) {
      debugPrint("checkWriteReview() 통신 확인");
      bool check = response.body.toLowerCase() == 'true';
      return check;
    } else {
      throw Exception("checkWriteReview() 에러 발생");
    }
  }
}

class RequestProductReview {
  int reviewNo;
  String writer;
  int starRating;
  String content;
  String regDate;
  String updDate;

  RequestProductReview({
    required this.reviewNo,
    required this.writer,
    required this.starRating,
    required this.content,
    required this.regDate,
    required this.updDate
  });

  factory RequestProductReview.fromJson(Map<String, dynamic> json) {
    return RequestProductReview(
        reviewNo: json['reviewNo'],
        writer: json['writer'],
        starRating: json['starRating'],
        content: json['content'],
        regDate: json['regDate'],
        updDate: json['updDate']
    );
  }
}

class RequestProductReviewImage {
  int reviewImageId;
  String editedName;

  RequestProductReviewImage({required this.reviewImageId, required this.editedName});

  factory RequestProductReviewImage.fromJson(Map<String, dynamic> json) {
    return RequestProductReviewImage(
      reviewImageId: json['reviewImageId'],
      editedName: json['editedName']
    );
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

class RequestMyReview {
  int reviewNo;
  String writer;
  int starRating;
  String content;
  String regDate;
  String updDate;
  int productNo;
  String productTitle;

  RequestMyReview({
    required this.reviewNo,
    required this.writer,
    required this.starRating,
    required this.content,
    required this.regDate,
    required this.updDate,
    required this.productNo,
    required this.productTitle
  });

  factory RequestMyReview.fromJson(Map<String, dynamic> json) {
    return RequestMyReview(
      reviewNo: json['reviewNo'],
      writer: json['writer'],
      starRating: json['starRating'],
      content: json['content'],
      regDate: json['regDate'],
      updDate: json['updDate'],
      productNo: json['productNo'],
      productTitle: json['productTitle']
    );
  }
}