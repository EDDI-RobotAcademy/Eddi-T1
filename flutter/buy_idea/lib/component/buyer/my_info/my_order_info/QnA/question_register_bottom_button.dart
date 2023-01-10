import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionRegisterBottomButton extends StatelessWidget {
  const QuestionRegisterBottomButton({Key? key, required this.contentController})
      : super(key: key);
  final TextEditingController contentController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          if (contentController.text.isNotEmpty) {
            ///spring API 요청
            // reviewRegister.then((value) {
            //   if (value) {
            //     showDialog(
            //         barrierDismissible: false,
            //         context: context,
            //         builder: (BuildContext context) {
            //           return AlertDialog(
            //             backgroundColor: Colors.white.withOpacity(0.7),
            //             title: Text('📝️'),
            //             content: Text(
            //               '문의가 정상적으로 등록되었습니다.',
            //               textAlign: TextAlign.center,
            //             ),
            //             actions: [
            //               TextButton(
            //                   onPressed: () {
            //                    Get.back();
            //                   },
            //                   child: Text('확인')
            //               )
            //             ],
            //           );
            //         }
            //     );
            //   }
            // });
          } else {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.white.withOpacity(0.7),
                    title: Text('⚠'),
                    content: Text(
                        '문의할 내용을 입력해 주세요.', textAlign: TextAlign.center),
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
        child: Text('문의 등록하기',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        style: ElevatedButton.styleFrom(
            elevation: 0,
            fixedSize: Size(MediaQuery
                .of(context)
                .size
                .width - 20, 60),
            primary: Color(0xff2F4F4F)
        ));
  }
}
