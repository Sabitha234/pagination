import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mvc_and_getx/Controller/NewsController.dart';
import 'package:mvc_and_getx/Model/NewsModel.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  final NewsController newscontroller=Get.put(NewsController());
  //late ScrollController controller;
   String message="";
  @override
  void initState(){
    // controller=ScrollController();
    // controller.addListener(()=>_scrollListener());
    super.initState();
}
  // _scrollListener() {
  //   final maxExtent = controller.position.maxScrollExtent;
  //   final minExtent = controller.position.minScrollExtent;
  //
  //   // Check if the user is currently scrolling.
  //   final isScrolling = controller.position.activity?.isScrolling ?? false;
  //
  //   // If the scroll position exceeds the bounds and the user is not actively scrolling,
  //   // animate back to the nearest bound.
  //   if (!isScrolling) {
  //     if (controller.offset > maxExtent) {
  //       controller.animateTo(
  //         maxExtent,
  //         duration: const Duration(milliseconds: 250),
  //         curve: Curves.easeInOut,
  //       );
  //     } else if (controller.offset < minExtent) {
  //       controller.animateTo(
  //         minExtent,
  //         duration: const Duration(milliseconds: 250),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   } else {
  //     // If the user is actively scrolling and has reached the end of the list,
  //     // animate back to the top.
  //     final maxScroll = controller.position.maxScrollExtent;
  //     final currentScroll = controller.position.pixels;
  //      final viewportDimension = controller.position.viewportDimension;
  //
  //     if (maxScroll - currentScroll <= viewportDimension) {
  //       controller.animateTo(
  //         0,
  //         duration: const Duration(milliseconds: 250),
  //         curve: Curves.easeInOut,
  //       );
  //     }
  //   }
  // }
  //
  //
  //
  // @override
  // void dispose() {
  //   controller.removeListener(_scrollListener);
  //   controller.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    print(newscontroller.news.length);
    return Scaffold(
      appBar: AppBar(title: Text("GetX"),
        centerTitle: true,
      backgroundColor: Colors.grey,
      ),
      body: Obx(
          ()=>newscontroller.isLoading.value?
              Center(child: CircularProgressIndicator()):
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: ListView.builder(
                  controller: newscontroller.scrollController,
                  itemCount:newscontroller.news.length,
                  itemBuilder: (BuildContext context, int index) {
                    NewsModel news=newscontroller.news[index];
                  // print(index);
                    return
                        Column(
                          children: [
                            Card(
                              child: ListTile(
                                title: Text(news.title),
                                subtitle: Text(news.author),
                              ),
                            ),SizedBox(height: 10,)
                          ],
                        );
                  },
                ),
              )
      ),
    );
  }
}
