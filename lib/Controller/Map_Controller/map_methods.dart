import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:usak_seramik_app/Controller/extension.dart';

double calculateDistance(LatLng reference, LatLng target) {
  const double earthRadius = 6371.0; // Dünya yarıçapı (km)
  double dLat = (target.latitude - reference.latitude).toRadians();
  double dLon = (target.longitude - reference.longitude).toRadians();
  double a = sin(dLat / 2) * sin(dLat / 2) + cos((reference.latitude).toRadians()) * cos((target.latitude).toRadians()) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c; // Mesafe (km)
  return distance;
}
