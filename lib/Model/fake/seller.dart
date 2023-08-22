import 'package:google_maps_flutter/google_maps_flutter.dart';

class Point {
  late int id;
  late String title;
  late String phone;
  late String fax;
  late String? email;
  late String address;
  late LatLng coordinate;
  Point({
    required this.id,
    required this.title,
    required this.address,
    this.email,
    required this.coordinate,
    required this.fax,
    required this.phone,
  });
}

List<Point> sellerList = [
  Point(id: 0, title: "ADA BALKAYA TİCARET MUAMMER BALKAYA", address: "Şöförler Odası Karşısı Yeni Sakarya Cad No:309 / A Erenler / Adapazarı / Sakarya", coordinate: LatLng(40.755010, 30.415310), fax: " 0(264) 241 10 16", phone: " 0(264) 241 10 15"),
  Point(id: 1, title: "ADEM TEKELİ-YARENLER TİCARET -2", address: "Akdeniz Mah. A.Türkeş Bulv. No:425/A Erdemli / Mersin", coordinate: LatLng(36.600060, 34.298840), fax: " 0(264) 241 10 16", phone: " 0(264) 241 10 15"),
  Point(id: 2, title: "AHİ GÜVEN İNŞAAT MALZ. KAL. D. GAZ. ZİR. AL. SAN. LTD. ŞTİ.", address: "Kuş Dilli Mah. Eski Bugday Pazarı 2 Merkez / Kırşehir", coordinate: LatLng(39.145120, 34.156400), fax: " 0(264) 241 10 16", phone: " 0(264) 241 10 15"),
  Point(id: 3, title: "AKAR SERAMİK SAN. TİC. A.Ş", address: "İnönü Cd. N:84 Mahmutbey Bağcılar / İstanbul", coordinate: LatLng(41.055950, 28.829320), fax: " 0(264) 241 10 16", phone: " 0(264) 241 10 15"),
  Point(id: 4, title: "AKAR SIHHI TES. MALZ. LTD. ŞTİ.", address: "Rüzgarlı Sk. Eser İşhanı No:14 / 5 Ulus / Ankara", coordinate: LatLng(39.943870, 32.851250), fax: " 0(264) 241 10 16", phone: " 0(264) 241 10 15"),
  Point(id: 5, title: "AKDENİZ YAPI İNŞ.MALZ.", address: "Demirtaş mah.Atatürk cad.no:81/A Alanya/ANTALYA", coordinate: LatLng(36.556237, 31.976895), fax: " 0(264) 241 10 16", phone: " 0(264) 241 10 15"),
  Point(id: 6, title: "ADA BALKAYA TİCARET MUAMMER BALKAYA", address: "Uşak-Banaz Devlet Ka. 26.Km. Uşak Seramik K.Banaz / Uşak", coordinate: LatLng(38.707370, 29.695680), fax: " 0(264) 241 10 16", phone: " 0(264) 241 10 15"),
];

List<Point> addressList = [
  Point(id: 0, title: "center", address: "Hamza Yerlikaya Bulvarı Çekmeköy Yolu No:11 Dudullu - Ümraniye / İSTANBUL", phone: "+ 90 216 527 67 67", fax: "+ 90 216 527 67 67", email: "info@usakseramik.com", coordinate: LatLng(38.739940, 29.752370)),
  Point(id: 1, title: "fabrica", address: "Dilek Mahallesi Değirmenler Sokak No:100 Banaz 64500 Uşak", phone: "+ 90 276 326 20 01", fax: "+ 90 276 326 20 11", email: "info@usakseramik.com", coordinate: LatLng(41.020860, 29.167400)),
];
