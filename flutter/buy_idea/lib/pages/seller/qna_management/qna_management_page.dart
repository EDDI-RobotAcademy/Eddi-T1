import 'package:buy_idea/component/seller/qna_management/answer_complete_form.dart';
import 'package:flutter/material.dart';

import '../../../component/seller/qna_management/wait_for_answer_form.dart';

class QnaManagementPage extends StatefulWidget {
  const QnaManagementPage({Key? key}) : super(key: key);

  @override
  State<QnaManagementPage> createState() => _QnaManagementPageState();
}

class _QnaManagementPageState extends State<QnaManagementPage> with TickerProviderStateMixin{

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  Widget _tabMenu(String menu) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
          menu,
          style: TextStyle(fontSize: 13, color: Colors.black)
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text('문의 관리', style: TextStyle(color: Colors.black, fontSize: 15)),
        elevation: 0,
        bottom: PreferredSize(
          child: Container(
            height: AppBar().preferredSize.height,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey),
                    top: BorderSide(color: Colors.grey, width: 0.1)
                )
            ),
            child: TabBar(
              controller: tabController,
              indicatorColor: const Color(0xff2F4F4F),
              tabs: [
                _tabMenu('답변 대기'),
                _tabMenu('답변 완료'),
              ],
            ),
          ),
          preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          SingleChildScrollView(child: WaitForAnswerForm()),
          SingleChildScrollView(child: AnswerCompleteForm()),
        ],
      ),
    );
  }
}
