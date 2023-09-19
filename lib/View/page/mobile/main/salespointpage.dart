import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/Map_Controller/get_position.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Controller/stopwatch.dart';
import 'package:usak_seramik_app/Rest/Controller/Dealer/dealer_controller.dart';
import 'package:usak_seramik_app/Rest/Entity/Dealer/dealer_entity.dart';
import 'package:usak_seramik_app/View/widget/dialog/dialog.dart';

import '../../../../Controller/Map_Controller/map_methods.dart';
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
  ValueNotifier<String?> searchSalesName = ValueNotifier<String?>(null);
  ValueNotifier<bool> expand = ValueNotifier<bool>(false);
  ValueNotifier<bool> clickOnNearest = ValueNotifier<bool>(false);
  ValueNotifier<double> nearestDistance = ValueNotifier<double>(0);
  TextEditingController salesNameController = TextEditingController();
  var defaultPosition = CameraPosition(target: LatLng(38.6730023335095, 29.40315111635541), zoom: 6.5);
  late Completer<GoogleMapController> _controller;
  late DealerData dealerData;

  @override
  void initState() {
    stopwatchTick('sıfırlama');
    super.initState();
    _controller = Completer<GoogleMapController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      stopwatchTick('magazalar getDealerController öncesi');
      setMarkers(Provider.of<DealerController>(context, listen: false).dealerData.data!, context).then((value) {
        if (mounted) {
          setState(() {});
        }
      });
    });
    fetchJson().whenComplete(() {});
    // selectedSeller.addListener(() async {
    //   final GoogleMapController controllerData = await _controller.future;
    //   if (selectedSeller.value != null) {
    //     controllerData.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: selectedSeller.value!.coordinate, zoom: 16)));
    //   } else {
    //     controllerData.animateCamera(CameraUpdate.newCameraPosition(defaultPosition));
    //   }
    // });
  }

  @override
  void dispose() {
    selectedCity.dispose();
    searchSalesName.dispose();
    clickOnNearest.dispose();
    nearestDistance.dispose();
    expand.dispose();
    super.dispose();
  }

  Future fetchJson() async {
    final json = jsonDecode(await DefaultAssetBundle.of(context).loadString(AppData.iller));
    for (var item in json['iller']) cities.add(City.fromMap(item));
  }

  @override
  Widget build(BuildContext context) {
    dealerData = Provider.of<DealerController>(context, listen: true).dealerData;
    return (dealerData.data == null)
        ? SizedBox()
        : Scaffold(
            key: _key,
            drawer: ContactDrawer(),
            endDrawer: _filterDrawer(dealerData),
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
            body: body(context, dealerData),
          );
  }

  Widget body(BuildContext context, DealerData dealerData) {
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
                  child: RefreshIndicator(
                    onRefresh: () async => Provider.of<DealerController>(context, listen: false).getDealerController(dealerFilterEntity: DealerFilterEntity(city_id: selectedCity.value, name: salesNameController.text)).then((value) {
                      if (mounted) {
                        setMarkers(dealerData.data!, context).then((value) {
                          setState(() {});
                        });
                      }
                    }),
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
                                      ? Column(
                                          children: [
                                            (clickOnNearest.value)
                                                ? CupertinoButton(
                                                    onPressed: () async {
                                                      Position myPosition = await determinePosition();
                                                      _findNearSeller(myPosition).then((nearestSeller) async {
                                                        final GoogleMapController controllerData = await _controller.future;
                                                        if (selectedSeller.value != nearestSeller) {
                                                          selectedSeller.value = nearestSeller;
                                                          clickOnNearest.value = true;
                                                          showMarkerDialog.value = true;
                                                          if (nearestSeller.latitude != null && nearestSeller.longitude != null) {
                                                            nearestDistance.value = calculateDistance(LatLng(myPosition.latitude, myPosition.longitude), LatLng(double.tryParse(nearestSeller.latitude!)!, double.tryParse(nearestSeller.longitude!)!));
                                                          }
                                                          controllerData.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng((nearestSeller.latitude != null) ? double.parse(nearestSeller.latitude!) : 0, (nearestSeller.longitude != null) ? double.parse(nearestSeller.longitude!) : 0), zoom: 16)));
                                                        } else {
                                                          selectedSeller.value = null;
                                                          clickOnNearest.value = false;
                                                          showMarkerDialog.value = false;
                                                          nearestDistance.value = 0;
                                                          controllerData.animateCamera(CameraUpdate.newCameraPosition(defaultPosition));
                                                        }

                                                        debugPrint('selected ${nearestSeller.runtimeType}');
                                                        // selectedSeller.value = nearestSeller;
                                                        setState(() {});
                                                      });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        IconButton(
                                                          onPressed: () {},
                                                          icon: Icon(FontAwesomeIcons.locationDot),
                                                        ),
                                                        Text(clickOnNearest.value ? context.translete("all") : context.translete("findNearSeller")),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            addressCard(selectedSeller.value!),
                                          ],
                                        )
                                      : SingleChildScrollView(
                                          // padding: EdgeInsets.only(top: 20),
                                          child: Column(
                                            children: [
                                              ValueListenableBuilder(
                                                  valueListenable: clickOnNearest,
                                                  builder: (context, _, __) {
                                                    return Column(
                                                      children: [
                                                        CupertinoButton(
                                                          onPressed: () async {
                                                            Position myPosition = await determinePosition();
                                                            _findNearSeller(myPosition).then((nearestSeller) async {
                                                              final GoogleMapController controllerData = await _controller.future;
                                                              if (selectedSeller.value != nearestSeller) {
                                                                selectedSeller.value = nearestSeller;
                                                                clickOnNearest.value = true;
                                                                showMarkerDialog.value = true;
                                                                if (nearestSeller.latitude != null && nearestSeller.longitude != null) {
                                                                  nearestDistance.value = calculateDistance(LatLng(myPosition.latitude, myPosition.longitude), LatLng(double.tryParse(nearestSeller.latitude!)!, double.tryParse(nearestSeller.longitude!)!));
                                                                }
                                                                controllerData.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng((nearestSeller.latitude != null) ? double.parse(nearestSeller.latitude!) : 0, (nearestSeller.longitude != null) ? double.parse(nearestSeller.longitude!) : 0), zoom: 16)));
                                                              } else {
                                                                selectedSeller.value = null;
                                                                clickOnNearest.value = false;
                                                                showMarkerDialog.value = false;
                                                                nearestDistance.value = 0;
                                                                controllerData.animateCamera(CameraUpdate.newCameraPosition(defaultPosition));
                                                              }

                                                              debugPrint('selected ${nearestSeller.runtimeType}');
                                                              // selectedSeller.value = nearestSeller;
                                                              setState(() {});
                                                            });
                                                          },
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              IconButton(
                                                                onPressed: () {},
                                                                icon: Icon(FontAwesomeIcons.locationDot),
                                                              ),
                                                              Text(clickOnNearest.value ? context.translete("all") : context.translete("findNearSeller")),
                                                            ],
                                                          ),
                                                        ),
                                                        // (clickOnNearest.value) ? ValueListenableBuilder(
                                                        //   valueListenable: nearestDistance,
                                                        //   builder: (context, value, child) {
                                                        //     return Text('~${nearestDistance.value.toStringAsFixed(0)}KM uzaklıkta');
                                                        //   },
                                                        // ) : SizedBox()
                                                      ],
                                                    );
                                                  }),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                // padding: EdgeInsets.only(top: 20),
                                                itemCount: dealerData.data!.length,
                                                itemBuilder: (context, index) {
                                                  final data = dealerData.data![index];
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
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget addressCard(DealerEntity data) {
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
                        controllerData.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng((data.latitude != null) ? double.parse(data.latitude!) : 0, (data.longitude != null) ? double.parse(data.longitude!) : 0), zoom: 16)));
                      } else {
                        selectedSeller.value = null;
                        controllerData.animateCamera(CameraUpdate.newCameraPosition(defaultPosition));
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(child: Text(data.name ?? "").wrapPaddingHorizontal(10)),
                        (selectedSeller.value == data) ? Text(context.translete('selected'), style: context.textStyle.copyWith(color: context.theme.iconTheme.color)).wrapPaddingRight(20) : Text(context.translete('select'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)).wrapPaddingRight(20),
                      ],
                    ),
                  ),
                  Divider(color: context.theme.dividerColor.withOpacity(.25)),
                  GestureDetector(
                    onTap: () async => launchMapsUrl((data.latitude != null) ? double.parse(data.latitude!) : 0, (data.longitude != null) ? double.parse(data.longitude!) : 0),
                    child: Row(children: [
                      Expanded(child: Text(data.address ?? "", style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
                      Row(
                        children: [
                          Text(context.translete('getRoute'), style: context.textStyle.copyWith(color: context.theme.colorScheme.outlineVariant)),
                          Icon(FontAwesomeIcons.locationArrow, size: 14, color: context.theme.colorScheme.outlineVariant).wrapPaddingRight(10).wrapPaddingLeft(5),
                        ],
                      ),
                    ]).wrapPaddingTop(15).wrapPaddingHorizontal(10),
                  ),
                  GestureDetector(
                    onTap: () async => launchPhone(data.phone1 ?? ""),
                    child: Row(children: [
                      Expanded(child: Text(data.phone1 ?? "", style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
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
                      Expanded(child: Text(data.fax ?? "", style: context.theme.textTheme.bodySmall!.copyWith(fontSize: 14))),
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

  Drawer _filterDrawer(DealerData dealerData) {
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
                              controller: salesNameController,
                              onChanged: (val) {
                                setState(() {});
                              },
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
                                  onChanged: (value) {
                                    setState(() {
                                      selectedCity.value = value;
                                    });
                                  },
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
                      Provider.of<DealerController>(context, listen: false).getDealerController(dealerFilterEntity: DealerFilterEntity(city_id: selectedCity.value, name: salesNameController.text)).then((value) {
                        if (mounted) {
                          setMarkers(dealerData.data!, context).then((value) {
                            setState(() {});
                          });
                        }
                      });
                      Navigator.pop(context);
                    },
                    child: Text(context.translete('search')))
                .wrapPaddingTop(20),
            salesNameController.text.isNotEmpty || selectedCity.value != null
                ? GestureDetector(
                    onTap: () {
                      salesNameController.clear();
                      selectedCity.value = null;
                      Provider.of<DealerController>(context, listen: false).getDealerController(dealerFilterEntity: DealerFilterEntity()).then((value) {
                        if (mounted) {
                          setMarkers(dealerData.data!, context).then((value) {
                            setState(() {});
                          });
                        }
                      });
                    },
                    child: Text(context.translete('clear')).wrapPaddingTop(20))
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Future<DealerEntity> _findNearSeller(Position myPosition) async {
    DealerEntity? nearestDealer;
    if (dealerData.data != null) {
      List<DealerEntity> allDealer = dealerData.data!;

      // ignore: unnecessary_null_comparison
      if (myPosition != null) {
        double minDistance = double.infinity;

        for (DealerEntity dealer in allDealer) {
          if (dealer.latitude != null && dealer.longitude != null) {
            double distance = calculateDistance(
              LatLng(myPosition.latitude, myPosition.longitude),
              LatLng(double.tryParse(dealer.latitude!)!, double.tryParse(dealer.longitude!)!),
            );

            if (distance < minDistance) {
              minDistance = distance;
              nearestDealer = dealer;
            }
          }
        }

        if (nearestDealer != null) {
          print("En yakın bayi: ${nearestDealer.name} : ${nearestDealer.address}");
        } else {
          appDialog(context, message: 'Bulunamadı', dialogType: DialogType.failed);
        }
      } else {}
    }
    return nearestDealer!;
  }
}
