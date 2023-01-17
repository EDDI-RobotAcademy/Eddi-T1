import 'package:buy_idea/component/seller/my_info/seller_business_info_register_button.dart';
import 'package:buy_idea/component/seller/my_info/seller_info_data.dart';
import 'package:flutter/material.dart';

import '../../../api/seller/spring_seller_info_api.dart';
import '../../../pages/seller/seller_main_page.dart';

class SellerBusinessInfoCard extends StatefulWidget {
  const SellerBusinessInfoCard({Key? key}) : super(key: key);

  @override
  State<SellerBusinessInfoCard> createState() => _SellerBusinessInfoCardState();
}

class _SellerBusinessInfoCardState extends State<SellerBusinessInfoCard> {
  bool loading = false;
  bool infoCheck = false;
  SellerInfoData sellerInfoData = SellerInfoData(
      realName: '',
      phone: '',
      registrationNumber: '',
      city: '',
      street: '',
      addressDetail: '',
      zipcode: '');

  @override
  void initState() {
    _getSpringSellerInfo();
    super.initState();
  }

  _getSpringSellerInfo() async {
    SellerInfoData sellerInfo = await SpringSellerInfoApi()
        .getSellerInfo(SellerMainPage.sellerNickname);

    if (SpringSellerInfoApi.sellerInfoResponse.statusCode == 200) {
      setState(() {
        sellerInfoData = SellerInfoData(
            realName: sellerInfo.realName,
            phone: sellerInfo.phone,
            registrationNumber: sellerInfo.registrationNumber,
            city: sellerInfo.city,
            street: sellerInfo.street,
            addressDetail: sellerInfo.addressDetail,
            zipcode: sellerInfo.zipcode);

        infoCheck = true;
        loading = true;
      });
    } else {
      setState(() {
        loading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!loading) {
      return Container(
        height: 620.0,
        child: Center(
          child: CircularProgressIndicator(color: Color(0XFF2F4F4F)),
        ),
      );
    } else {
      if (infoCheck == false) {
        /// 정보 없을 때
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Text('사업자 등록 정보',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('상호명')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 30.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 6.0),
                          child: Text(
                            SellerMainPage.sellerNickname,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('대표명')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 30.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 6.0),
                          child: Text(
                            '정보 없음',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('업체 전화번호')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 30.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text('정보 없음',
                              style: TextStyle(color: Colors.grey)),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('사업자 등록번호')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 30.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text('정보 없음',
                              style: TextStyle(color: Colors.grey)),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('업체 주소')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 60.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 6.0, top: 17.0, bottom: 17.0),
                          child: Text('정보 없음',
                              style: TextStyle(color: Colors.grey)),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Center(
                  child: Text(
                '현재 등록된 사업자 정보가 없습니다.',
                style: TextStyle(fontSize: 12),
              )),
              Center(
                  child: Text(
                '아래 버튼을 눌러 정보 등록을 진행해주세요.',
                style: TextStyle(fontSize: 12),
              )),
              SizedBox(height: 10.0),
              BusinessInfoRegisterButton(
                infoCheck: false,
              ),
              SizedBox(height: 30.0),
            ],
          ),
        );
      } else {
        /// 정보 있을 때
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 30.0),
              Text('사업자 등록 정보',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 40.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('상호명')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 30.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 6.0),
                          child: Text(
                            SellerMainPage.sellerNickname,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('대표명')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 30.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 4.0, bottom: 4.0, left: 6.0),
                          child: Text(
                            sellerInfoData.realName,
                            style: TextStyle(color: Colors.grey),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('업체 전화번호')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 30.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(sellerInfoData.phone,
                              style: TextStyle(color: Colors.grey)),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('사업자 등록번호')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 30.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(sellerInfoData.registrationNumber,
                              style: TextStyle(color: Colors.grey)),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    SizedBox(width: 100.0, child: Text('업체 주소')),
                    SizedBox(width: 10.0),
                    Container(
                        width: 250.0,
                        height: 60.0,
                        color: Color(0xFFe8e8e8),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                              '(${sellerInfoData.zipcode}) ${sellerInfoData.city} '
                              '${sellerInfoData.street} ${sellerInfoData.addressDetail}',
                              style: TextStyle(color: Colors.grey)),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 65.0),
              BusinessInfoRegisterButton(
                infoCheck: true,
              ),
              SizedBox(height: 40.0),
            ],
          ),
        );
      }
    }
  }
}
