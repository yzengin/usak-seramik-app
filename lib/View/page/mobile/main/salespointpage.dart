import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Model/fake/seller.dart';

import '../../../../Controller/Map_Controller/marker_create.dart';
import '../../../../Controller/launcher.dart';
import '../../../../Model/city.dart';
import '../../../widget/drawer/contact_drawer.dart';
import '../../../widget/utility/copy_on_tap.dart';

class SalesPointsPage extends StatefulWidget {
  const SalesPointsPage({super.key});

  @override
  State<SalesPointsPage> createState() => _SalesPointsPageState();
}

class _SalesPointsPageState extends State<SalesPointsPage> {
  final _key = GlobalKey<ScaffoldState>();
  List<City> cities = [];
  ValueNotifier<int?> selectedCity = ValueNotifier<int?>(null);
  ValueNotifier<bool> expand = ValueNotifier<bool>(false);
  // ValueNotifier<String> selectedView = ValueNotifier<String>('domestic');

  var defaultPosition = CameraPosition(target: LatLng(39, 35.3191), zoom: 4.8);
  late Completer<GoogleMapController> _controller;

  @override
  void initState() {
    _controller = Completer<GoogleMapController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        setMarkers(sellerList, context).then((value) {
          setState(() {});
        });
      }
    });
    fetchJson().whenComplete(() {
      setState(() {});
    });
    // selectedSeller.addListener(() async {
    //   final GoogleMapController controllerData = await _controller.future;
    //   if (selectedSeller.value != null) {
    //     controllerData.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: selectedSeller.value!.coordinate, zoom: 16)));
    //   } else {
    //     controllerData.animateCamera(CameraUpdate.newCameraPosition(defaultPosition));
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    selectedCity.dispose();
    super.dispose();
  }

  Future fetchJson() async {
    final json = jsonDecode(await DefaultAssetBundle.of(context).loadString(AppData.iller));
    for (var item in json['iller']) cities.add(City.fromMap(item));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: ContactDrawer(),
      endDrawer: _filterDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: AppBar(
              backgroundColor: context.theme.scaffoldBackgroundColor.withOpacity(0.75),
              centerTitle: true,
              title: Text(context.translete('stores')),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight * 0.5),
                child: DefaultTabController(
                  length: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: ['domestic', 'overseas']
                        .map((e) => GestureDetector(
                            onTap: () {
                              if (e == 'overseas') {
                                Navigator.pushNamed(context, AppRoutes.overseas_page);
                              }
                            },
                            child: Text(
                              context.translete(e),
                              style: context.textStyle.copyWith(color: e == 'domestic' ? context.textStyle.color : context.textStyle.color!.withOpacity(.5)),
                            ).wrapPaddingHorizontal(10)))
                        .toList(),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    _key.currentState!.openEndDrawer();
                  },
                  icon: Icon(FontAwesomeIcons.filter),
                ),
              ],
            ),
          ),
        ),
      ),
      body: bodyDomestic(context),
      // body: ValueListenableBuilder(
      //   valueListenable: selectedView,
      //   builder: (context, value, child) {
      //     return selectedView.value == "domestic" ? bodyDomestic(context) : bodyOverseas(context);
      //   },
      // ),
    );
  }

  Widget bodyOverseas(BuildContext context) {
    List<String> ulkeler = [
      "ABD",
      "ALMANYA",
      "ANGOLA",
      "ARJANTIN",
      "ARNAVUTLUK",
      "AZERBAYCAN",
      "BOSNA",
      "BULGARİSTAN",
      "ÇEK CUMHURİYETİ",
      "FİLDİŞİ",
      "FRANSA",
      "GAMBİA",
      "GÜRCİSTAN",
      "IRAK",
      "İNGİLTERE",
      "İSRAİL",
      "İSVEÇ",
      "KANADA",
      "KIBRIS",
      "KOSOVA",
      "MAKEDONYA",
      "MALİ",
      "MALTA",
      "POLANYA",
      "ROMANYA",
      "SENEGAL",
      "SIRBISTAN",
      "ŞİLİ",
      "TÜRKMENİSTAN",
      "UGANDA",
      "YUNANİSTAN",
    ];

    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Image.network('https://www.usakseramik.com/img/overseas_salespoints.jpg'),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(top: 20),
            itemCount: ulkeler.length,
            itemBuilder: (context, index) {
              final data = ulkeler[index];
              return Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: context.textStyle.color!.withOpacity(.25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          (index + 1).toString(),
                        ).wrapPaddingHorizontal(10),
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(border: Border.all(color: context.textStyle.color!)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(data),
                      ),
                    ),
                  ],
                ),
              ).wrapPaddingBottom(20);
            },
          )
        ],
      ),
    );
  }

  Widget bodyDomestic(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: expand,
        builder: (context, _, __) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Column(
              children: [
                Card(
                  elevation: 10,
                  margin: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: AspectRatio(
                    aspectRatio: expand.value ? (context.width / (context.height - kToolbarHeight * 4)) : 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ValueListenableBuilder(
                          valueListenable: expand,
                          builder: (context, _, __) {
                            return ValueListenableBuilder(
                                valueListenable: allMarkers,
                                builder: (context, _, __) {
                                  return Stack(
                                    children: [
                                      GoogleMap(
                                        initialCameraPosition: defaultPosition,
                                        markers: Set<Marker>.of(allMarkers.value),
                                        buildingsEnabled: false,
                                        compassEnabled: false,
                                        indoorViewEnabled: false,
                                        mapToolbarEnabled: false,
                                        myLocationButtonEnabled: true,
                                        myLocationEnabled: true,
                                        tiltGesturesEnabled: true,
                                        zoomGesturesEnabled: true,
                                        rotateGesturesEnabled: true,
                                        scrollGesturesEnabled: true,
                                        onTap: (argument) {
                                          showMarkerDialog.value = false;
                                          selectedSeller.value = null;
                                        },
                                        onMapCreated: (GoogleMapController controller) {
                                          try {
                                            _controller.complete(controller);
                                          } catch (e) {
                                            debugPrint('EXCEPTION  GOOGLE MAP CONTROLLER-- $e');
                                          }
                                        },
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: () {
                                              expand.value = !expand.value;
                                            },
                                            icon: Icon(FontAwesomeIcons.expand, color: Colors.black)),
                                      )
                                    ],
                                  );
                                });
                          }),
                    ),
                  ),
                ),
                Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: showMarkerDialog,
                      builder: (context, _, __) {
                        return ValueListenableBuilder(
                            valueListenable: selectedSeller,
                            builder: (context, _, __) {
                              return AnimatedCrossFade(
                                crossFadeState: expand.value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                alignment: Alignment.centerRight,
                                duration: 300.millisecond(),
                                firstChild: SizedBox(),
                                secondChild: (showMarkerDialog.value == true && selectedSeller.value != null)
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: addressCard(selectedSeller.value!),
                                      )
                                    : SingleChildScrollView(
                                        // padding: EdgeInsets.only(top: 20),
                                        child: Column(
                                          children: [
                                            CupertinoButton(
                                              onPressed: () {},
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(FontAwesomeIcons.locationDot),
                                                  ),
                                                  Text(context.translete("findNearSeller")),
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              // padding: EdgeInsets.only(top: 20),
                                              itemCount: sellerList.length,
                                              itemBuilder: (context, index) {
                                                final data = sellerList[index];
                                                return Padding(
                                                  padding: EdgeInsets.only(bottom: 20),
                                                  child: addressCard(data),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                              );
                            });
                      }),
                )
              ],
            ),
          );
        });
  }

  Widget addressCard(Point data) {
    return ValueListenableBuilder(
        valueListenable: selectedSeller,
        builder: (context, _, __) {
          return Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final GoogleMapController controllerData = await _controller.future;
                      if (selectedSeller.value != data) {
                        selectedSeller.value = data;
                        controllerData.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: data.coordinate, zoom: 16)));
                      } else {
                        selectedSeller.value = null;
                        controllerData.animateCamera(CameraUpdate.newCameraPosition(defaultPosition));
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(child: Text(data.title).wrapPaddingHorizontal(10)),
                        (selectedSeller.value == data) ? Text(context.translete('selected'), style: context.textStyle.copyWith(color: context.theme.iconTheme.color)).wrapPaddingRight(20) : Text(context.translete('select'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)).wrapPaddingRight(20),
                      ],
                    ),
                  ),
                  Divider(color: context.theme.dividerColor.withOpacity(.25)),
                  GestureDetector(
                    onTap: () async => launchMapsUrl(data.coordinate.latitude, data.coordinate.longitude),
                    child: Row(children: [
                      Expanded(child: Text(data.address, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                      Row(
                        children: [
                          Text(context.translete('getRoute'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                          Icon(FontAwesomeIcons.locationArrow, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                        ],
                      ),
                    ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                  ),
                  GestureDetector(
                    onTap: () async => launchPhone(data.phone),
                    child: Row(children: [
                      Expanded(child: Text(data.phone, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                      Row(
                        children: [
                          Text(context.translete('call'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                          Icon(FontAwesomeIcons.phone, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                        ],
                      ),
                    ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                  ),
                  GestureDetector(
                    onTap: () async => launchMail(data.email ?? ""),
                    child: Row(children: [
                      Expanded(child: Text(data.fax, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                      CopyOnTap(
                        '${data.fax}',
                        delay: 1.second(),
                        child: Row(
                          children: [
                            Text(context.translete('fax'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                            Icon(FontAwesomeIcons.fax, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                          ],
                        ),
                      ),
                      // Icon(FontAwesomeIcons.fax, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10),
                    ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                  ),
                  (data.email == null)
                      ? SizedBox()
                      : GestureDetector(
                          onTap: () async => launchMail(data.email ?? ""),
                          child: Row(children: [
                            Expanded(child: Text(data.email!, style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                            Row(
                              children: [
                                Text(context.translete('email'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                                Icon(FontAwesomeIcons.solidEnvelope, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                              ],
                            ),
                          ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                        ),
                ],
              ),
            ),
          );
        });
  }

  Drawer _filterDrawer() {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.only(
          top: context.paddingTop,
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          children: [
            (cities.isEmpty)
                ? SizedBox()
                : ValueListenableBuilder(
                    valueListenable: selectedCity,
                    builder: (context, _, __) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Column(
                          children: [
                            TextField(
                              decoration: InputDecoration(hintText: context.translete('searchSalePoint'), hintStyle: context.textStyle.copyWith(color: context.textStyle.color!.withOpacity(.5))),
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(border: Border.all(color: context.textStyle.color!), borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                child: DropdownButton(
                                  items: cities.map((e) => DropdownMenuItem(child: Text(e.title.toString()), value: e.code)).toList(),
                                  value: selectedCity.value,
                                  isExpanded: true,
                                  onChanged: (value) => selectedCity.value = value,
                                  underline: SizedBox(),
                                  iconEnabledColor: context.textStyle.color,
                                  iconDisabledColor: context.textStyle.color!.withOpacity(.5),
                                  hint: Text(context.translete('allCities'), style: context.textStyle.copyWith(color: context.textStyle.color!.withOpacity(.5))),
                                  style: context.textStyle,
                                  dropdownColor: context.theme.scaffoldBackgroundColor,
                                ),
                              ),
                            ).wrapPaddingTop(20),
                          ],
                        ),
                      );
                    },
                  ),
            ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(context.translete('search')))
                .wrapPaddingTop(20)
          ],
        ),
      ),
    );
  }
}
