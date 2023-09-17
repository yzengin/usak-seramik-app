import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class ProductSurfaceData extends Persistent{
  List<ProductSurfaceEntity?>? data;
  String? message;
  bool? status;
  int? total;

  ProductSurfaceData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory ProductSurfaceData.fromJson(Map<String, dynamic> json) {
    return ProductSurfaceData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductSurfaceEntity.fromJson(e as Map<String, dynamic>))
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

class ProductSurfaceEntity extends Persistent{
  int? id;
  Name? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductSurfaceEntity({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductSurfaceEntity.fromJson(Map<String, dynamic> json) {
    return ProductSurfaceEntity(
      id: json['id'] as int?,
      name: Name.fromJson(json['name']),
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

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      en: json['en'] as String?,
      tr: json['tr'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['en'] = this.en;
    data['tr'] = this.tr;
    return data;
  }
}
