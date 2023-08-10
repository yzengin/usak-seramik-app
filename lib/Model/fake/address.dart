class Address {
  late int id;
  late String title;
  late String address;
  late String phone;
  late String fax;
  late String email;
  late double latitute;
  late double longtitute;
  Address({
    required this.id,
    required this.title,
    required this.address,
    required this.phone,
    required this.fax,
    required this.email,
    required this.latitute,
    required this.longtitute,
  });
}

List<Address> addressList = [
  Address(id: 0, title: "center", address: "Hamza Yerlikaya Bulvarı Çekmeköy Yolu No:11 Dudullu - Ümraniye / İSTANBUL", phone: "+ 90 216 527 67 67", fax: "+ 90 216 527 67 67", email: "info@usakseramik.com", latitute: 38.739940, longtitute: 29.752370),
  Address(id: 1, title: "fabrica", address: "Dilek Mahallesi Değirmenler Sokak No:100 Banaz 64500 Uşak", phone: "+ 90 276 326 20 01", fax: "+ 90 276 326 20 11", email: "info@usakseramik.com", latitute: 41.020860, longtitute: 29.167400),
];
