import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class ProductDetailData extends Persistent{
  ProductDetailEntity? data;
  String? message;
  bool? status;

  ProductDetailData({
    this.data,
    this.message,
    this.status,
  });

  factory ProductDetailData.fromJson(Map<String, dynamic> json) {
    return ProductDetailData(
      data: ProductDetailEntity.fromJson(json['data']),
      message: json['message'] as String?,
      status: json['status'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data?.toJson();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class ProductDetailEntity extends Persistent{
  int? id;
  dynamic productCollectionId;
  int? productTypeId;
  String? name;
  String? slug;
  Description? description;
  int? sortOrder;
  bool? active;
  DateTime? createdAt;
  DateTime? updatedAt;
  DataImages? images;
  List<Feature>? features;

  ProductDetailEntity({
    this.id,
    this.productCollectionId,
    this.productTypeId,
    this.name,
    this.slug,
    this.description,
    this.sortOrder,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.images,
    this.features,
  });

  factory ProductDetailEntity.fromJson(Map<String, dynamic> json) {
    return ProductDetailEntity(
      id: json['id'] as int?,
      productCollectionId: json['product_collection_id'],
      productTypeId: json['product_type_id'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      description: Description.fromJson(json['description']),
      sortOrder: json['sort_order'] as int?,
      active: json['active'] as bool?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      images: DataImages.fromJson(json['images']),
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => Feature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['product_collection_id'] = this.productCollectionId;
    data['product_type_id'] = this.productTypeId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description?.toJson();
    data['sort_order'] = this.sortOrder;
    data['active'] = this.active;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    data['images'] = this.images?.toJson();
    data['features'] = this.features?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Description {
  String? tr;

  Description({
    this.tr,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    return Description(
      tr: json['tr'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tr'] = this.tr;
    return data;
  }
}

class Feature {
  int? id;
  int? productId;
  dynamic? productTypeId;
  FaceSizeId? faceSizeId;
  FaceColorId? faceSurfaceId;
  FaceColorId? faceColorId;
  FaceColorId? faceGlossId;
  FaceId? faceThicknessId;
  FaceId? faceStructureId;
  Description? name;
  Description? slug;
  Description? description;
  int? antiSlip;
  int? rectification;
  int? relief;
  bool? active;
  int? sortOrder;
  DateTime? createdAt;
  DateTime? updatedAt;
  Ebatlar? ebatlar;
  FeatureImages? images;
  List<FaceColorId>? usageArea;

  Feature({
    this.id,
    this.productId,
    this.productTypeId,
    this.faceSizeId,
    this.faceSurfaceId,
    this.faceColorId,
    this.faceGlossId,
    this.faceThicknessId,
    this.faceStructureId,
    this.name,
    this.slug,
    this.description,
    this.antiSlip,
    this.rectification,
    this.relief,
    this.active,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.ebatlar,
    this.images,
    this.usageArea,
  });

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      id: json['id'] as int?,
      productId: json['product_id'] as int?,
      productTypeId: json['product_type_id'],
      faceSizeId: FaceSizeId.fromJson(json['face_size_id']),
      faceSurfaceId: FaceColorId.fromJson(json['face_surface_id']),
      faceColorId: FaceColorId.fromJson(json['face_color_id']),
      faceGlossId: FaceColorId.fromJson(json['face_gloss_id']),
      faceThicknessId: FaceId.fromJson(json['face_thickness_id']),
      faceStructureId: FaceId.fromJson(json['face_structure_id']),
      name: Description.fromJson(json['name']),
      slug: Description.fromJson(json['slug']),
      description: Description.fromJson(json['description']),
      antiSlip: json['anti_slip'] as int?,
      rectification: json['rectification'] as int?,
      relief: json['relief'] as int?,
      active: json['active'] as bool?,
      sortOrder: json['sort_order'] as int?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      ebatlar: Ebatlar.fromJson(json['ebatlar']),
      images: FeatureImages.fromJson(json['images']),
      usageArea: (json['usage_area'] as List<dynamic>?)
          ?.map((e) => FaceColorId.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_type_id'] = this.productTypeId;
    data['face_size_id'] = this.faceSizeId?.toJson();
    data['face_surface_id'] = this.faceSurfaceId?.toJson();
    data['face_color_id'] = this.faceColorId?.toJson();
    data['face_gloss_id'] = this.faceGlossId?.toJson();
    data['face_thickness_id'] = this.faceThicknessId?.toJson();
    data['face_structure_id'] = this.faceStructureId?.toJson();
    data['name'] = this.name?.toJson();
    data['slug'] = this.slug?.toJson();
    data['description'] = this.description?.toJson();
    data['anti_slip'] = this.antiSlip;
    data['rectification'] = this.rectification;
    data['relief'] = this.relief;
    data['active'] = this.active;
    data['sort_order'] = this.sortOrder;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    data['ebatlar'] = this.ebatlar?.toJson();
    data['images'] = this.images?.toJson();
    data['usage_area'] = this.usageArea?.map((e) => e.toJson()).toList();
    return data;
  }
}

class Ebatlar {
  int? id;
  int? productFaceId;
  String? pieceInBox;
  String? boxSize;
  String? palletSize;
  String? boxInPallet;
  String? boxWeight;
  String? palletDimensions;
  DateTime? createdAt;
  DateTime? updatedAt;

  Ebatlar({
    this.id,
    this.productFaceId,
    this.pieceInBox,
    this.boxSize,
    this.palletSize,
    this.boxInPallet,
    this.boxWeight,
    this.palletDimensions,
    this.createdAt,
    this.updatedAt,
  });

  factory Ebatlar.fromJson(Map<String, dynamic> json) {
    return Ebatlar(
      id: json['id'] as int?,
      productFaceId: json['product_face_id'] as int?,
      pieceInBox: json['piece_in_box'] as String?,
      boxSize: json['box_size'] as String?,
      palletSize: json['pallet_size'] as String?,
      boxInPallet: json['box_in_pallet'] as String?,
      boxWeight: json['box_weight'] as String?,
      palletDimensions: json['pallet_dimensions'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['product_face_id'] = this.productFaceId;
    data['piece_in_box'] = this.pieceInBox;
    data['box_size'] = this.boxSize;
    data['pallet_size'] = this.palletSize;
    data['box_in_pallet'] = this.boxInPallet;
    data['box_weight'] = this.boxWeight;
    data['pallet_dimensions'] = this.palletDimensions;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    return data;
  }
}

class FaceColorId {
  int? id;
  Name? name;
  String? code;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? sortOrder;

  FaceColorId({
    this.id,
    this.name,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.sortOrder,
  });

  factory FaceColorId.fromJson(Map<String, dynamic> json) {
    return FaceColorId(
      id: json['id'] as int?,
      name: Name.fromJson(json['name']),
      code: json['code'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      sortOrder: json['sort_order'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name?.toJson();
    data['code'] = this.code;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    data['sort_order'] = this.sortOrder;
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

class FaceSizeId {
  int? id;
  String? name;
  String? width;
  String? height;
  DateTime? createdAt;
  DateTime? updatedAt;

  FaceSizeId({
    this.id,
    this.name,
    this.width,
    this.height,
    this.createdAt,
    this.updatedAt,
  });

  factory FaceSizeId.fromJson(Map<String, dynamic> json) {
    return FaceSizeId(
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

class FaceId {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  FaceId({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory FaceId.fromJson(Map<String, dynamic> json) {
    return FaceId(
      id: json['id'] as int?,
      name: json['name'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt?.toIso8601String();
    data['updated_at'] = this.updatedAt?.toIso8601String();
    return data;
  }
}

class FeatureImages {
  String? faces;
  String? image;

  FeatureImages({
    this.faces,
    this.image,
  });

  factory FeatureImages.fromJson(Map<String, dynamic> json) {
    return FeatureImages(
      faces: json['faces'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['faces'] = this.faces;
    data['image'] = this.image;
    return data;
  }
}

class DataImages {
  String? cover;
  String? thumb;

  DataImages({
    this.cover,
    this.thumb,
  });

  factory DataImages.fromJson(Map<String, dynamic> json) {
    return DataImages(
      cover: json['cover'] as String?,
      thumb: json['thumb'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cover'] = this.cover;
    data['thumb'] = this.thumb;
    return data;
  }
}
