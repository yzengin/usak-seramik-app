import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:usak_seramik_app/Rest/Entity/Dealer/dealer_entity.dart';
import '../asset.dart';
import '../controller.dart';

ValueNotifier<List<Marker>> allMarkers = ValueNotifier([]);
List<Marker> allMarkersMidLevel = [];
ValueNotifier<bool> showMarkerDialog = ValueNotifier<bool>(false);
ValueNotifier<DealerEntity?> selectedSeller = ValueNotifier<DealerEntity?>(null);
Uint8List? mapMarker;

Future<void> setMarkers(List<DealerEntity> dataList, BuildContext context) async {
  allMarkersMidLevel.clear();
  final Uint8List markerIcon = await getBytesFromAsset(AppIcon.mapmarker, ((MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio) * 0.1).toInt());
  if (dataList.isNotEmpty) {
    try {
      for (var data in dataList) {
        allMarkersMidLevel.add(Marker(
          markerId: MarkerId(data.name ?? ""),
          position: LatLng((data.latitude != null) ? double.parse(data.latitude!) : 0, (data.longitude != null) ? double.parse(data.longitude!) : 0),
          // infoWindow: InfoWindow(title: '${plakaList.firstWhere((map) => map.keys.first == data.cityId).values.first}', snippet: data.name),
          infoWindow: InfoWindow(title: '${data.phone1}', snippet: data.name),
          onTap: () {
            showMarkerDialog.value = true;
            selectedSeller.value = data;
            // debugPrint('${plakaList.firstWhere((map) => map.keys.first == data.cityId).values.first}');
          },
          icon: BitmapDescriptor.fromBytes(markerIcon), //Icon for Marker
        ));
      }
    } catch (e) {
      debugPrint("Marker Create Catch -- $e");
    }
  }

  allMarkers.value.clear();
  allMarkers.value.addAll(allMarkersMidLevel);
}
