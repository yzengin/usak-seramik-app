import 'package:usak_seramik_app/Rest/Entity/Product/product_detail_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class ProductData extends Persistent{
    List<ProductEntity>? data;
    String? message;
    bool? status;
    int? total;

    ProductData({
        this.data,
        this.message,
        this.status,
        this.total,
    });

    factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
        data: (json["data"] as List<dynamic>?)?.map((x) => ProductEntity.fromJson(x)).toList(),
        message: json["message"] as String?,
        status: json["status"] as bool?,
        total: json["total"] as int?,
    );

    Map<String, dynamic> toJson() => {
        "data": data?.map((x) => x.toJson()).toList(),
        "message": message,
        "status": status,
        "total": total,
    };
}

class ProductEntity extends Persistent{
    int? id;
    dynamic productCollectionId;
    ProductTypeId? productTypeId;
    String? name;
    String? slug;
    Description? description;
    int? sortOrder;
    bool? active;
    DateTime? createdAt;
    DateTime? updatedAt;
    ImagesClass? images;
    int? faceCount;
    int? colorCount;
    int? sizeCount;

    ProductEntity({
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
        this.faceCount,
        this.colorCount,
        this.sizeCount,
    });

    factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
        id: json["id"],
        productCollectionId: json["product_collection_id"],
        productTypeId: json["product_type_id"]== null ? null : ProductTypeId.fromJson(json["product_type_id"]),
        name: json["name"],
        slug: json["slug"],
        description: json["description"] == null ? null : Description.fromJson(json["description"]),
        sortOrder: json["sort_order"],
        active: json["active"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        images: json["images"] == null ? null : ImagesClass.fromJson(json["images"]),
        faceCount: json["face_count"],
        colorCount: json["color_count"],
        sizeCount: json["size_count"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_collection_id": productCollectionId,
        "product_type_id": productTypeId?.toJson(),
        "name": name,
        "slug": slug,
        "description": description?.toJson(),
        "images": images?.toJson(),
        "sort_order": sortOrder,
        "active": active,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "face_count": faceCount,
        "color_count": colorCount,
        "size_count": sizeCount,
    };

    // CONVERT
    factory ProductEntity.fromProductDetailEntity(ProductDetailEntity product) => ProductEntity(
        id: product.id,
        productCollectionId: null,
        productTypeId: ProductTypeId(tr: product.productTypeId.toString()),
        name: product.name,
        slug: product.slug,
        description: (product.description == null) ? null : Description(tr: product.description!.tr),
        sortOrder: product.sortOrder,
        active: product.active,
        createdAt: product.createdAt,
        updatedAt: product.updatedAt,
        images: product.images == null ? null : ImagesClass(
          cover: product.images!.cover,
          thumb: product.images!.thumb,
        ),
        faceCount: null,
        colorCount: null,
        sizeCount: null,
    );
}

class Description {
    String? tr;

    Description({
        this.tr,
    });

    factory Description.fromJson(Map<String, dynamic> json) => Description(
        tr: json["tr"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "tr": tr,
    };
}

class ImagesClass {
    String? cover;
    String? thumb;

    ImagesClass({
        this.cover,
        this.thumb,
    });

    factory ImagesClass.fromJson(Map<String, dynamic> json) => ImagesClass(
        cover: json["cover"] as String?,
        thumb: json["thumb"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "cover": cover,
        "thumb": thumb,
    };
}

class ProductTypeId {
    String? en;
    String? tr;

    ProductTypeId({
        this.en,
        this.tr,
    });

    factory ProductTypeId.fromJson(Map<String, dynamic> json) => ProductTypeId(
        en: json["en"] as String?,
        tr: json["tr"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "en": en,
        "tr": tr,
    };
}
