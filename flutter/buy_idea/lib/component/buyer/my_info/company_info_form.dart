import 'package:flutter/material.dart';

class CompanyInfoForm extends StatefulWidget {
  const CompanyInfoForm({Key? key}) : super(key: key);

  @override
  State<CompanyInfoForm> createState() => _CompanyInfoFormState();
}

class _CompanyInfoFormState extends State<CompanyInfoForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5.0),
          Text('(주) Eddi T1',
              style: TextStyle(fontSize: 14, color: Colors.black)),
          SizedBox(height: 3.0),
          Text('개발팀 : 김소연 | 박선호 | 임재범 | 조안나 | 진건오',
              style: TextStyle(fontSize: 12, color: Colors.black45)),
          Text('사업자 등록번호 123-45-67890',
              style: TextStyle(fontSize: 12, color: Colors.black45)),
          Text('통신판매업 서울 강남-0987 | 호스팅서비스 제공자 (주)Eddi T1',
              style: TextStyle(fontSize: 12, color: Colors.black45)),
          Text('CS@eddi.t1.com | 서울특별시 강남구 에디대로 티원빌딩',
              style: TextStyle(fontSize: 12, color: Colors.black45)),
          Text('전자금융분쟁처리 Tel 1234-5678(유료), 080-123-4567(무료)',
              style: TextStyle(fontSize: 12, color: Colors.black45)),
          Text('Fax 050-1234-5678',
              style: TextStyle(fontSize: 12, color: Colors.black45)),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15.0),
                width: 180.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '고객센터(대표) \n 1234-5678 \n 24시간 운영, 연중무휴',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ),
              SizedBox(width: 4.0),
              Container(
                padding: EdgeInsets.all(15.0),
                width: 180.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white30),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '고객센터(바이디어 스토어) \n 1234-0987 \n 오전 09:00~익일 새벽 01:00',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Text(
              '(주)Eddi T1은 통신판매중개자이며, 통신판매의 당사자가 아닙니다. \n '
                  '따라서 (주)Eddi T1은 상품, 거래정보 및 거래에 대하여 책임을 지지 않습니다.',
              style: TextStyle(fontSize: 12, color: Colors.black45)),
        ],
      ),
    );
  }
}
