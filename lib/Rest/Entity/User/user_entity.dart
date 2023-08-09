import '/Rest/Entity/persistent.dart';

class UserData {
  bool? success;
  dynamic message;
  UserEntity? data;

  UserData({
    this.success,
    this.message,
    this.data,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        success: json["success"],
        message: json["message"],
        data: UserEntity.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class UserEntity extends Persistent {
  String? id;
  String? name;
  String? email;

  UserEntity({
    this.id,
    this.email,
    this.name,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "name": name == null ? null : name,
      };
}
