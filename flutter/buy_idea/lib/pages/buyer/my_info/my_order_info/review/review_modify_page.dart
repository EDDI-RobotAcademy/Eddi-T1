import 'dart:io';

import 'package:buy_idea/api/spring_review_api.dart';
import 'package:buy_idea/component/buyer/app_bar/title_top_bar.dart';
import 'package:buy_idea/component/buyer/my_info/my_order_info/review/review_register_text_field_form.dart';
import 'package:buy_idea/pages/buyer/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReviewModifyPage extends StatefulWidget {
  final int reviewNo;
  final String productTitle;
  final String content;
  final int starRating;
  const ReviewModifyPage({
    Key? key,
    required this.reviewNo,
    required this.productTitle,
    required this.content,
    required this.starRating
  }) : super(key: key);

  @override
  State<ReviewModifyPage> createState() => _ReviewModifyPageState();
}

class _ReviewModifyPageState extends State<ReviewModifyPage> {

  final ImagePicker _picker = ImagePicker();
  XFile? file;
  int starRating = 0;

  _pickedImageFromGallery() async {
    XFile? imageFile = await _picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        file = imageFile;
      });
    }
  }

  final TextEditingController contentController = TextEditingController();
  static final storage = FlutterSecureStorage();
  String? nickname;
  var future;

  _asyncMethod() async {
    nickname = await storage.read(key: 'nickname');
  }
  @override
  void initState() {
    future = _asyncMethod();
    contentController.text = widget.content;
    starRating = widget.starRating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // 메소드가 완료되지 않았다면 로딩표시 애니메이션을 화면에 띄움
          return Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                color: Color(0xff2F4F4F),
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: TitleTopBar(titleText: '상품 구매 후기 수정'),
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(height: 20, color: Colors.grey, thickness: 1),
                    Row(
                      children: [
                        SizedBox(
                            width: 70,
                            child: Text(
                                '상품',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                textAlign: TextAlign.center
                            )
                        ),
                        Expanded(
                          child: Text(
                              widget.productTitle,
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis
                              )
                          ),
                        )
                      ],
                    ),
                    Divider(height: 20, color: Colors.grey, thickness: 1),
                    SizedBox(height: 5),
                    if (file == null)
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: GestureDetector(
                              onTap: () {
                                _pickedImageFromGallery();
                              },
                              child: Icon(Icons.add_photo_alternate_outlined, size: 50)
                          ),
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: () {
                          _pickedImageFromGallery();
                        },
                        child: Container(
                          width: 300,
                          height: 300,
                          decoration: BoxDecoration(
                            // border: Border.all(),
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: FileImage(File(file!.path)),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                    SizedBox(height: 10),
                    Divider(height: 15, color: Colors.grey, thickness: 1),
                    Row(
                      children: [
                        SizedBox(
                            width: 70,
                            child: Text(
                                '별점',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                textAlign: TextAlign.center
                            )
                        ),
                        Expanded(
                          child: Center(
                            child: RatingBar.builder(
                                initialRating: starRating.toDouble(),
                                minRating: 1,
                                itemCount: 5,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                tapOnlyMode: true,
                                itemSize: 20,
                                itemPadding: EdgeInsets.symmetric(horizontal: 3),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  starRating = rating.toInt();
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 15, color: Colors.grey, thickness: 1),
                    ReviewRegisterTextFieldForm(nickname: nickname!, contentController: contentController),
                    SizedBox(height: 90),
                  ],
                ),
              ),
            ),
            bottomSheet: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.black12))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (contentController.text.isNotEmpty) {
                        if (file != null) {
                          if (starRating != 0) {
                            var reviewRegister = SpringReviewApi().productReviewModify(
                                widget.reviewNo,
                                starRating,
                                contentController.text,
                                file!);

                            reviewRegister.then((value) {
                              if (value) {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white.withOpacity(0.7),
                                        title: Text('📝️'),
                                        content: Text(
                                          '후기가 정상적으로 수정되었습니다.\n메인페이지로 이동합니다.',
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Get.offAll(MainPage());
                                              },
                                              child: Text('확인')
                                          )
                                        ],
                                      );
                                    }
                                );
                              }
                            });
                          } else {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.white.withOpacity(0.7),
                                    title: Text('⚠'),
                                    content: Text('상품에 대한 만족도를\n별점을 통해 매겨주세요.', textAlign: TextAlign.center),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('확인')
                                      )
                                    ],
                                  );
                                }
                            );
                          }
                        } else {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor: Colors.white.withOpacity(0.7),
                                  title: Text('⚠'),
                                  content: Text('사진 등록은 필수입니다.', textAlign: TextAlign.center),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text('확인')
                                    )
                                  ],
                                );
                              }
                          );
                        }
                      } else {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.white.withOpacity(0.7),
                                title: Text('⚠'),
                                content: Text('후기 본문을 입력해주세요.', textAlign: TextAlign.center),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('확인')
                                  )
                                ],
                              );
                            }
                        );
                      }
                    },
                    child: Text('상품 구매 후기 수정', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size(MediaQuery.of(context).size.width - 20, 60),
                        primary: Color(0xff2F4F4F)
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }
    );
  }
}
