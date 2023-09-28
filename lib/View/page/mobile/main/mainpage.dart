import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/controller.dart';
import 'package:usak_seramik_app/View/page/mobile/detail/cart_detail_page.dart';
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
    _pageController = PageController(initialPage: PageViewIndexer.instance.currentIndex, keepPage: false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBar(
        items: mainNavBarItemList(context),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: PageViewIndexer.instance.currentIndex,
        onTap: (value) {
          _pageController.jumpToPage(value);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: (basketMode())
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => CartPage()));
              },
              elevation: 10,
              child: Icon(FontAwesomeIcons.cartShopping),
            )
          : SizedBox(),
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
      ),
    );
  }
}
