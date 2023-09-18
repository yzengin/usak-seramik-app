import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

import 'name_data_entity.dart';

class ProductUsageAreaData extends Persistent{
  List<NameDataEntity?>? data;
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