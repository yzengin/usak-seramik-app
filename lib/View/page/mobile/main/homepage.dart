import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/View/widget/view/home_textures_view.dart';
import '../../../widget/view/find_product_view.dart';
import '../../../widget/view/home_showreels_view.dart';

PageController pageViewController = PageController();
final Duration autoPlayDuration = 5.second();
final Duration autoPlayAnimationDuration = 700.millisecond();

List<Widget> pageItems = [
  Showreel(autoPlayDuration: autoPlayDuration, autoPlayAnimationDuration: autoPlayAnimationDuration),
  FindProductView(),
  ProductTexturesView()
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return PageView.builder(
      controller: pageViewController,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: pageItems.length,
      onPageChanged: (value) {},
      itemBuilder: (context, index) => pageItems[index],
    );
  }
}
