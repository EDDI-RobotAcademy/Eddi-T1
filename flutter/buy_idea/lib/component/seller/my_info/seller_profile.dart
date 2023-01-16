import 'package:flutter/material.dart';

import '../../../pages/seller/seller_main_page.dart';

class SellerProfile extends StatefulWidget {
  const SellerProfile({Key? key}) : super(key: key);

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/default_profile_image.png'),
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(SellerMainPage.sellerId,
              style: TextStyle(fontSize: 15, color: Colors.black)),
          SizedBox(height: 5.0),
          Text(SellerMainPage.sellerNickname,
              style: TextStyle(fontSize: 15, color: Colors.black)),
        ],
      ),
    );
  }
}
