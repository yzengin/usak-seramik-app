class City {
  City({this.title, this.code});

  late String? title;
  late int? code;

  factory City.fromMap(Map<String, dynamic> item) {
    return City(
      title: item["title"],
      code: item["code"],
    );
  }

  Map<String, dynamic> toMap() => {
        "title": title,
        "code": code,
      };
}
