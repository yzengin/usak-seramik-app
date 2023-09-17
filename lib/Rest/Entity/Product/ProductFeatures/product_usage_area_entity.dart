import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class ProductUsageAreaData extends Persistent{
  List<ProductUsageAreaEntity?>? data;
  String? message;
  bool? status;
  int? total;

  ProductUsageAreaData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory ProductUsageAreaData.fromJson(Map<String, dynamic> json) {
    return ProductUsageAreaData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductUsageAreaEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      status: json['status'] as bool?,
      total: json['total'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data?.map((e) => e!.toJson()).toList();
    data['message'] = this.message;
    data['status'] = this.status;
    data['total'] = this.total;
    return data;
  }
}

class ProductUsageAreaEntity extends Persistent {
  int? id;
  Name? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductUsageAreaEntity({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductUsageAreaEntity.fromJson(Map<String, dynamic> json) {
    return ProductUsageAreaEntity(
      id: json['id'] as int?,
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name?.toJson();
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    return data;
  }
}

class Name {
  String? en;
  String? tr;

  Name({
    this.en,
    this.tr,
  });

  factory Name.fromJson(Map<String, dynamic>? json) {
    return Name(
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
