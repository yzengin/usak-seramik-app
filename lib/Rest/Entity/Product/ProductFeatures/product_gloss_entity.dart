import '../../persistent.dart';

class ProductGlossData extends Persistent{
  List<ProductGlossEntity?>? data;
  String? message;
  bool? status;
  int? total;

  ProductGlossData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory ProductGlossData.fromJson(Map<String, dynamic> json) {
    return ProductGlossData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ProductGlossEntity.fromJson(e as Map<String, dynamic>))
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

class ProductGlossEntity extends Persistent{
  int? id;
  Name? name;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProductGlossEntity({
    this.id,
    this.name,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductGlossEntity.fromJson(Map<String, dynamic> json) {
    return ProductGlossEntity(
      id: json['id'] as int?,
      name: Name.fromJson(json['name']),
      sortOrder: json['sort_order'] as int?,
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
    data['sort_order'] = this.sortOrder;
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
