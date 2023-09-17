import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class ProductColorData extends Persistent{
  List<ProductColorEntity?>? data;
  String? message;
  bool? status;
  int? total;

  ProductColorData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory ProductColorData.fromJson(Map<String, dynamic> json) {
    return ProductColorData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductColorEntity.fromJson(e as Map<String, dynamic>))
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

class ProductColorEntity extends Persistent {
  int? id;
  Name? name;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductColorEntity({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductColorEntity.fromJson(Map<String, dynamic> json) {
    return ProductColorEntity(
      id: json['id'] as int?,
      name: Name.fromJson(json['name']),
      code: json['code'] as String?,
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
    data['code'] = this.code;
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
