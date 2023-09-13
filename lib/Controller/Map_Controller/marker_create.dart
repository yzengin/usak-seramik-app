import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:usak_seramik_app/Model/fake/seller.dart';
import '../asset.dart';
import '../controller.dart';

ValueNotifier<List<Marker>> allMarkers = ValueNotifier([]);
ValueNotifier<List<Marker>> allMarkersMidLevel = ValueNotifier([]);
ValueNotifier<bool> showMarkerDialog = ValueNotifier<bool>(false);
ValueNotifier<Point?> selectedSeller = ValueNotifier<Point?>(null);
Uint8List? mapMarker;

Future<void> setMarkers(List<Point> dataList, BuildContext context) async {
  if (dataList.isNotEmpty) {
    try {
      for (var data in dataList) {
        final Uint8List markerIcon = await getBytesFromAsset(AppIcon.mapmarker, ((MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio) * 0.1).toInt());
        allMarkersMidLevel.value.add(Marker(
          //add first marker
          markerId: MarkerId(data.title),
          position: LatLng(data.coordinate.latitude, data.coordinate.longitude),
          infoWindow: InfoWindow(
            title: data.title,
          ),
          onTap: () {
            showMarkerDialog.value = true;
            selectedSeller.value = data;
          },
          icon: BitmapDescriptor.fromBytes(markerIcon), //Icon for Marker
        ));
      }
    } catch (e) {
      debugPrint("Marker Create Catch -- $e");
    }
  }

  allMarkers.value.clear();
  allMarkers.value.addAll(allMarkersMidLevel.value);
}
