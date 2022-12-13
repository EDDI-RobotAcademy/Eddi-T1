import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HandmadeProductRegistrationStatusList extends StatefulWidget {
  const HandmadeProductRegistrationStatusList({Key? key}) : super(key: key);

  @override
  State<HandmadeProductRegistrationStatusList> createState() => _HandmadeProductRegistrationStatusListState();
}

class _HandmadeProductRegistrationStatusListState extends State<HandmadeProductRegistrationStatusList> {

  List<String> _productTitle = [
    '선물추천♡볼통통한 토끼 볼토 키링',
    '⭐️2주소요⭐️ 뜨개 호보백 (61 colors)',
    '✨하트 앨리스 키링✨ (핸드폰 줄 변경 가능👌)',
  ];

  List<String> _productContent = [
    '어쩌구 저쩌구 토끼 라라라라라랄 볼토 블라블라블라 키링 두구두구두구두구 투구 갑옷 아무말대잔치토스',
    '뜨개 호보백 2주일까 3주일까 모르겠지 61colors일까 62colors일까 궁금하지 나도 몰라 히히히히히',
    '하트 앨리스 키링 이상한 나라의 엘리스 키키 핸드폰 줄 변경 가능일 수도 있고 아닐 수도 설명설명수박명수까스활명수'
  ];

  List<String> _starRate = ['4.8', '4.5', '4.9'];
  List<String> _reviews = ['20', '55', '238'];
  List<String> _productRegisterDate = ['2022/12/10', '2022/11/23', '2022/11/09'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (BuildContext buildContext, int index) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              onTap: (){},
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
                              image: AssetImage('assets/product/handmade${index+1}.jpg')
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
          ),
        );
      })
    );
  }
}
