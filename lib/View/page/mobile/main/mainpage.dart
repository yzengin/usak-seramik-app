import 'package:flutter/material.dart';
import '../../../../Controller/page_indexer.dart';
import '../../../../Controller/routes.dart';

class MainPageView extends StatefulWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  MainPageViewState createState() => MainPageViewState();
}

class MainPageViewState extends State<MainPageView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: PageViewIndexer.instance.currentIndex, keepPage: true);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: SizedBox(
          height: kBottomNavigationBarHeight * 2,
          child: BottomNavigationBar(
            items: mainNavBarItemList(context),
            currentIndex: PageViewIndexer.instance.currentIndex,
            onTap: (value) {
              _pageController.jumpToPage(value);
            },
          ),
        ),
        body: PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => mainPageList[index],
          itemCount: mainPageList.length,
          onPageChanged: (value) {
            setState(() {
              PageViewIndexer.instance.next(value);
            });
          },
        ));
  }
}