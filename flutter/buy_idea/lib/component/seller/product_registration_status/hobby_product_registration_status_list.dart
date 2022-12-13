import 'package:flutter/material.dart';

class HobbyProductRegistrationStatusList extends StatefulWidget {
  const HobbyProductRegistrationStatusList({Key? key}) : super(key: key);

  @override
  State<HobbyProductRegistrationStatusList> createState() => _HobbyProductRegistrationStatusListState();
}

class _HobbyProductRegistrationStatusListState extends State<HobbyProductRegistrationStatusList> {

  List<String> _productTitle = [
    '재봉틀 수업',
    '십자수 수업',
    '에그타르트 만들기',
    '머랭쿠키 만들기'
  ];

  List<String> _productContent = [
    '누구나 쉽게 따라할 수 있는 재봉틀 수업! 수선집 가기 싫고 집에서 간단하게 수선하고 싶진 않으신가요? 그럴땐 이 수업을 들어보세요!',
    '유니크한 나만의 십자수 액자를 만들어보고 싶을 땐? 어디에도 팔지 않는 나만의 십자수 액자를 만들어보아요!',
    '에그타르트를 집에 쟁여놓고 먹고싶어요. 어디서도 공개하지않은 최고의 비율로 탄생한 나만의 에그타르트 비법을 최초 공개합니다!!!',
    '이거 완전 솜사탕 아니야?! 입안에서 살살녹는 머랭쿠키 누구나 만들 수 있다! 쉽게 배워보는 머랭쿠키 수업'
  ];

  List<String> _starRate = ['4.7', '4.3', '4.5', '4.2'];
  List<String> _reviews = ['110', '337', '208', '185'];
  List<String> _productRegisterDate = ['2022/12/10', '2022/11/23', '2022/11/09', '2022/10/13'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (BuildContext buildContext, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/product/hobby${index+1}.jpg')
                          ),
                          borderRadius: BorderRadius.circular(15)
                        ),
                      ),
                      VerticalDivider(),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  _productTitle[index],
                                  style: TextStyle(fontSize: 13)
                              ),
                              Divider(thickness: 1,),
                              Text(
                                  _productContent[index],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 11)
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star_rate, color: Colors.amber, size: 14,),
                                        SizedBox(width: 5),
                                        Text(_starRate[index], style: TextStyle(fontSize: 12),),
                                        Expanded(child: Text('별점', style: TextStyle(fontSize: 12), textAlign: TextAlign.end))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.rate_review_outlined, color: Colors.black, size: 14,),
                                        SizedBox(width: 5),
                                        Text(_reviews[index], style: TextStyle(fontSize: 12),),
                                        Expanded(child: Text('후기', style: TextStyle(fontSize: 12), textAlign: TextAlign.end))
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Icon(Icons.edit_calendar_outlined, color: Colors.black, size: 14,),
                                        SizedBox(width: 5),
                                        Text(_productRegisterDate[index], style: TextStyle(fontSize: 12),),
                                        Expanded(child: Text('등록일', style: TextStyle(fontSize: 12), textAlign: TextAlign.end,))
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                      )
                    ],
                  ),
                )
            ),
          ),
        );
      })
    );
  }
}
