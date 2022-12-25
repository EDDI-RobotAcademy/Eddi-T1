import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MyProfileForm extends StatefulWidget {
  const MyProfileForm({Key? key}) : super(key: key);

  @override
  State<MyProfileForm> createState() => _MyProfileFormState();
}

class _MyProfileFormState extends State<MyProfileForm> {
  static const storage = FlutterSecureStorage();
  dynamic memberNickname = '';
  dynamic memberMemberId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    memberNickname = await storage.read(key: 'nickname');
    memberMemberId = await storage.read(key: 'memberId');

    setState(() {
      memberNickname = memberNickname;
      memberMemberId = memberMemberId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 200, color: Colors.white, child: imageProfile()),
      ],
    );
  }

  Widget imageProfile() {
    return Center(
      child: Column(
        children: [
          Stack(children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  // 회원 프로필 불러와서 넣어줘야함
                  AssetImage('assets/default_profile_image.png'),
              backgroundColor: Colors.white,
            ),
            Positioned(
              bottom: 0,
              right: 5,
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100.0)),
                    color: Color(0xFF2F4F4F),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 20),
          Text(memberNickname, style: TextStyle(fontSize: 15)),
          const SizedBox(height: 10),
          Text(memberMemberId, style: TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            '프로필 사진을 선택해주세요.',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton.icon(
                  icon: Icon(Icons.camera_alt, color: Colors.black, size: 30),
                  onPressed: () {
                    //추후 연결
                  },
                  label: Text('카메라',
                      style: TextStyle(fontSize: 20, color: Colors.black))),
              TextButton.icon(
                  icon:
                      Icon(Icons.photo_library, color: Colors.black, size: 30),
                  onPressed: () {
                    //추후 연결
                  },
                  label: Text('갤러리',
                      style: TextStyle(fontSize: 20, color: Colors.black))),
            ],
          )
        ],
      ),
    );
  }
}
