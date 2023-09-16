import '../persistent.dart';

class ContactData extends Persistent {
  List<ContactEntity>? data;
  String? message;
  bool? status;
  int? total;

  ContactData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory ContactData.fromJson(Map<String, dynamic> json) {
    return ContactData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ContactEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
      status: json['status'] as bool?,
      total: json['total'] as int?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['data'] = this.data?.map((e) => e.toJson()).toList();
    data['message'] = this.message;
    data['status'] = this.status;
    data['total'] = this.total;
    return data;
  }
}

class ContactEntity extends Persistent{
  int? id;
  String? title;
  String? slug;
  String? address;
  String? tel;
  String? tel2;
  String? gsm;
  String? fax;
  String? email;
  String? lat;
  String? lng;
  dynamic image;
  String? created_at;
  String? updated_at;

  ContactEntity({
    this.id,
    this.title,
    this.slug,
    this.address,
    this.tel,
    this.tel2,
    this.gsm,
    this.fax,
    this.email,
    this.lat,
    this.lng,
    this.image,
    this.created_at,
    this.updated_at,
  });

  factory ContactEntity.fromJson(Map<String, dynamic> json) {
    return ContactEntity(
      id: json['id'] as int?,
      title: json['title'] as String?,
      slug: json['slug'] as String?,
      address: json['address'] as String?,
      tel: json['tel'] as String?,
      tel2: json['tel2'] as String?,
      gsm: json['gsm'] as String?,
      fax: json['fax'] as String?,
      email: json['email'] as String?,
      lat: json['lat'] as String?,
      lng: json['lng'] as String?,
      image: json['image'],
      created_at: json['created_at'] as String?,
      updated_at: json['updated_at'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['address'] = this.address;
    data['tel'] = this.tel;
    data['tel2'] = this.tel2;
    data['gsm'] = this.gsm;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['image'] = this.image;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}
