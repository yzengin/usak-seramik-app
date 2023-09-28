class EntryData<T, Object> {
  EntryData({
    this.key,
    this.data,
  });

  late dynamic key;
  late dynamic data;

  factory EntryData.fromMap(Map<String, dynamic> item) {
    return EntryData(
      key: item["key"],
      data: item["data"],
    );
  }

  Map<String, dynamic> toMap() => {
        "key": key,
        "data": data,
      };
  @override
  String toString() {
    return "$key : $data";
  }
}
