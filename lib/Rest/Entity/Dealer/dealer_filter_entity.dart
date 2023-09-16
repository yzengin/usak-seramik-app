import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class DealerFilterEntity extends Persistent{
  int? city_id;
  String? name;

  DealerFilterEntity({
    this.city_id,
    this.name,
  });

  factory DealerFilterEntity.fromJson(Map<String, dynamic> json) => DealerFilterEntity(
        city_id: json["city_id"] as int?,
        name: json["name"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "city_id": city_id,
        "name": name,
      };
}
