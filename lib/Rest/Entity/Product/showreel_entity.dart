import '../persistent.dart';

class ShowreelData extends Persistent {
  List<ShowreelEntity>? data;
  String? message;
  bool? status;
  int? total;

  ShowreelData({
    this.data,
    this.message,
    this.status,
    this.total,
  });

  factory ShowreelData.fromJson(Map<String, dynamic> json) {
    return ShowreelData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ShowreelEntity.fromJson(e as Map<String, dynamic>))
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

class ShowreelEntity extends Persistent {
  int? id;
  String? img;
  Title? title;
  Subtitle? subtitle;
  Content? content;
  Url? url;
  LinkText? linktext;
  bool? active;
  int? mobile;
  int? order;
  String? createdAt;
  String? updatedAt;
  Images? images;

  ShowreelEntity({
    this.id,
    this.img,
    this.title,
    this.subtitle,
    this.content,
    this.url,
    this.linktext,
    this.active,
    this.mobile,
    this.order,
    this.createdAt,
    this.updatedAt,
    this.images,
  });

  factory ShowreelEntity.fromJson(Map<String, dynamic> json) {
    return ShowreelEntity(
      id: json['id'] as int?,
      img: json['img'] as String?,
      title: Title.fromJson(json['title']),
      subtitle: Subtitle.fromJson(json['subtitle']),
      content: Content.fromJson(json['content']),
      url: Url.fromJson(json['url']),
      linktext: LinkText.fromJson(json['linktext']),
      active: json['active'] as bool?,
      mobile: json['mobile'] as int?,
      order: json['order'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      images: Images.fromJson(json['images']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['title'] = this.title?.toJson();
    data['subtitle'] = this.subtitle?.toJson();
    data['content'] = this.content?.toJson();
    data['url'] = this.url?.toJson();
    data['linktext'] = this.linktext?.toJson();
    data['active'] = this.active;
    data['mobile'] = this.mobile;
    data['order'] = this.order;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['images'] = this.images?.toJson();
    return data;
  }
}

class Title {
  String? en;
  String? tr;

  Title({
    this.en,
    this.tr,
  });

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(
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

class Subtitle {
  String? tr;

  Subtitle({
    this.tr,
  });

  factory Subtitle.fromJson(Map<String, dynamic> json) {
    return Subtitle(
      tr: json['tr'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tr'] = this.tr;
    return data;
  }
}

class Content {
  String? en;
  String? tr;

  Content({
    this.en,
    this.tr,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
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

class Url {
  String? en;
  String? tr;

  Url({
    this.en,
    this.tr,
  });

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
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

class LinkText {
  String? en;
  String? tr;

  LinkText({
    this.en,
    this.tr,
  });

  factory LinkText.fromJson(Map<String, dynamic> json) {
    return LinkText(
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

class Images {
  String? trImage;
  String? enImage;

  Images({
    this.trImage,
    this.enImage,
  });

  factory Images.fromJson(Map<String, dynamic> json) {
    return Images(
      trImage: json['tr-image'] as String?,
      enImage: json['en-image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['tr-image'] = this.trImage;
    data['en-image'] = this.enImage;
    return data;
  }
}
