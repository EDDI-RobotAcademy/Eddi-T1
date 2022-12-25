import 'package:flutter/material.dart';

import '../../../component/buyer/app_bar/title_top_bar.dart';
import '../../../component/buyer/my_info/company_info_form.dart';

class ServiceCenterPage extends StatefulWidget {
  const ServiceCenterPage({Key? key}) : super(key: key);

  @override
  State<ServiceCenterPage> createState() => _ServiceCenterPageState();
}

class _ServiceCenterPageState extends State<ServiceCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: const TitleTopBar(titleText: '고객센터'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.grey,
                child: Column(
                  children: const [
                    CompanyInfoForm(),
                  ]
                ),
                ),
          ],
        ),
      ),
    );
  }
}
