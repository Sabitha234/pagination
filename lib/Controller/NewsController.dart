import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Model/NewsModel.dart';
import'package:http/http.dart'as http;
class NewsController extends GetxController{
 List<NewsModel> news=[];
  var isLoading = false.obs;
  int currentPage=1;
 late ScrollController scrollController;
  @override
  void onInit() {
    // TODO: implement onInit
    scrollController=ScrollController();
    scrollController.addListener(_loadMore);
    fetchData(currentPage);
    super.onInit();

  }
 @override
 void dispose() {
   scrollController.dispose();
   super.dispose();
 }
 void _loadMore() {
   if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
     if(currentPage<4) {
       currentPage++;
       news=[];
       print("current page: $currentPage");
       fetchData(currentPage);

     }

     if(currentPage==4) {
       currentPage++;
     }
     if(currentPage==5){
       currentPage=1;
       print("current page: $currentPage");
       news=[];
       fetchData(currentPage);
     }
   }
   if (scrollController.position.pixels == scrollController.position.minScrollExtent) {
     currentPage=1;
       print("current page: $currentPage");
       news=[];
       fetchData(currentPage);

   }
 }

  fetchData(int pageKey)async {
try {
  isLoading(true);
  var response = await http.get(Uri.parse(
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=6c5e0ca05f5f490e92ca6c71def772d8&page=$pageKey"));
  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    List<dynamic> articles = responseData['articles'];
    for (Map<String, dynamic> article in articles) {
      if (article['title'] != null && article['author'] != null) {
        print(NewsModel
            .fromJson(article)
            .title);
        news.add(NewsModel.fromJson(article));

      }
    }
    print("length${news.length}");
  }
  else {
    print("Error fetching data");
  }
 }
     catch(e){
     print("error while processing data");
    }
    finally{
      isLoading(false);
    }
  }
}