import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class NameDataEntity extends Persistent {
  int? id;
  NameTextEntity? name;
  String? colorCode;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;

  NameDataEntity({
    this.id,
    this.sortOrder,
    this.name,
    this.colorCode,
    this.createdAt,
    this.updatedAt,
  });

  factory NameDataEntity.fromJson(Map<String, dynamic> json) {
    return NameDataEntity(
      id: json['id'] as int?,
      sortOrder: json['sort_order'] as int?,
      colorCode: json['code'] as String?,
      name: NameTextEntity.fromJson(json['name'] as Map<String, dynamic>?),
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['sort_order'] = this.sortOrder;
    data['color'] = this.colorCode;
    data['name'] = this.name?.toJson();
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    return data;
  }
}

class NameTextEntity {
  String? en;
  String? tr;

  NameTextEntity({
    this.en,
    this.tr,
  });

  factory NameTextEntity.fromJson(Map<String, dynamic>? json) {
    return NameTextEntity(
      en: json?['en'] as String?,
      tr: json?['tr'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['en'] = this.en;
    data['tr'] = this.tr;
    return data;
  }
}
