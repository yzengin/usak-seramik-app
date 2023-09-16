import 'package:usak_seramik_app/Rest/Entity/persistent.dart';

class MessageEntity extends Persistent{
    String? name;
    String? email;
    String? subject;
    String? tel;
    String? message;

    MessageEntity({
        this.name,
        this.email,
        this.subject,
        this.tel,
        this.message,
    });

    factory MessageEntity.fromJson(Map<String, dynamic> json) => MessageEntity(
        name: json["name"] as String?,
        email: json["email"] as String?,
        subject: json["subject"] as String?,
        tel: json["tel"] as String?,
        message: json["message"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "subject": subject,
        "tel": tel,
        "message": message,
    };
}
