import 'package:flutter/material.dart';

class KnowHowProductRegistrationStatusList extends StatefulWidget {
  const KnowHowProductRegistrationStatusList({Key? key}) : super(key: key);

  @override
  State<KnowHowProductRegistrationStatusList> createState() => _KnowHowProductRegistrationStatusListState();
}

class _KnowHowProductRegistrationStatusListState extends State<KnowHowProductRegistrationStatusList> {

  List<String> _productTitle = [
    '계좌공개 실전매매 스켈핑 방법!',
    '급등주보다 매일챙기는 매매법',
  ];

  List<String> _productContent = [
    '계좌까지 공개한다! 실전매매 스켈핑 방법! 스켈레톤이 아니라 스켈핑이지롱 블라블라블라 가나다라초콜릿락스피릿리리맘보',
    '급등주보다 매일챙기는 매매법! 급등이 곱등이 곱창 기타등등 허리허리 허리업 다운 청기들고 백기내려 하하',
  ];

  List<String> _starRate = ['4.8', '4.5'];
  List<String> _reviews = ['20', '33'];
  List<String> _productRegisterDate = ['2022/12/10', '2022/11/23'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 2,
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
                            image: AssetImage('assets/product/knowhow${index+1}.jpg')
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
