import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class ProductSizeData extends Persistent {
  List<ProductSizeEntity?>? data;
  String? message;
  bool? status;
  int? total;

  ProductSizeData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory ProductSizeData.fromJson(Map<String, dynamic> json) {
    return ProductSizeData(
      data: (json['data'] as List<dynamic>?)?.map((e) => ProductSizeEntity.fromJson(e as Map<String, dynamic>)).toList(),
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

class ProductSizeEntity extends Persistent {
  int? id;
  String? name;
  String? width;
  String? height;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductSizeEntity({
    this.id,
    this.name,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductSizeEntity.fromJson(Map<String, dynamic> json) {
    return ProductSizeEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
      width: json['width'] as String?,
      height: json['height'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['width'] = this.width;
    data['height'] = this.height;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    return data;
  }
}
