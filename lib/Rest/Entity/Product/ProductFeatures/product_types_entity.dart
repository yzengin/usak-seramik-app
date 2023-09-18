import 'package:usak_seramik_app/Rest/Entity/Product/ProductFeatures/name_data_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class ProductTypesData extends Persistent {
  List<NameDataEntity?>? data;
  String? message;
  bool? status;
  int? total;

  ProductTypesData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory ProductTypesData.fromJson(Map<String, dynamic> json) {
    return ProductTypesData(
      data: (json['data'] as List<dynamic>?)?.map((e) => NameDataEntity.fromJson(e as Map<String, dynamic>)).toList(),
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