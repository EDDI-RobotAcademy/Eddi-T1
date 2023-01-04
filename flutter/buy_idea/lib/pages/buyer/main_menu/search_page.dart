import 'package:buy_idea/pages/buyer/main_menu/search_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var _searchController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: 35,
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                  // 엔터쳐서 API 요청
                textInputAction: TextInputAction.go,
                onSubmitted: (value) async{
                  _searchController.text = value;
                  if(value.isNotEmpty){
                    Get.to(SearchListPage(searchKeyword: value));
                  }
                },
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search, color: Colors.teal),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.teal),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
                    hintText: '검색어를 입력하세요.',
                    hintStyle: TextStyle(fontSize: 15),
                    border: InputBorder.none),
              ),
            ),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
        ));
  }
}
