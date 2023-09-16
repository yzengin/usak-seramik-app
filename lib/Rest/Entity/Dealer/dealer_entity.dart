import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class DealerData extends Persistent {
  List<DealerEntity?>? data;
  String? message;
  bool? status;
  int? total;

  DealerData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory DealerData.fromJson(Map<String, dynamic> json) => DealerData(
        data: (json["data"] as List<dynamic>?)?.map((x) => DealerEntity.fromJson(x)).toList(),
        message: json["message"] as String?,
        status: json["status"] as bool?,
        total: json["total"] as int?,
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x!.toJson())),
        "message": message,
        "status": status,
        "total": total,
      };
}

class DealerEntity extends Persistent {
  int? id;
  int? cityId;
  String? name;
  String? slug;
  String? phone1;
  String? phone2;
  String? fax;
  String? address;
  String? email;
  String? latitude;
  String? longitude;
  DateTime? createdAt;
  DateTime? updatedAt;

  DealerEntity({
    this.id,
    this.cityId,
    this.name,
    this.slug,
    this.phone1,
    this.phone2,
    this.fax,
    this.address,
    this.email,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  factory DealerEntity.fromJson(Map<String, dynamic> json) => DealerEntity(
        id: json["id"] as int?,
        cityId: json["city_id"] as int?,
        name: json["name"] as String?,
        slug: json["slug"] as String?,
        phone1: json["phone1"] as String?,
        phone2: json["phone2"] as String?,
        fax: json["fax"] as String?,
        address: json["address"] as String?,
        email: json["email"] as String?,
        latitude: json["latitude"] as String?,
        longitude: json["longitude"] as String?,
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city_id": cityId,
        "name": name,
        "slug": slug,
        "phone1": phone1,
        "phone2": phone2,
        "fax": fax,
        "address": address,
        "email": email,
        "latitude": latitude,
        "longitude": longitude,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
