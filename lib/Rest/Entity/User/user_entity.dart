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
  String? lastName;
  String? password;
  String? email;

  UserEntity({
    this.id,
    this.name,
    this.lastName,
    this.password,
    this.email,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
      id: json["id"] == null ? null : json["id"],
      name: json["name"] == null ? null : json["name"],
      lastName: json["lastName"] == null ? null : json["lastName"],
      password: json["password"] == null ? null : json["password"],
      email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
      "id": id == null ? null : id,
      "name": name == null ? null : name,
      "lastName": lastName == null ? null : lastName,
      "password": password == null ? null : password,
      "email": email == null ? null : email,
  };
}
