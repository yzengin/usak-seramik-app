
// ignore_for_file: prefer_if_null_operators

import '/Rest/Entity/persistent.dart';

class LoginEntity extends Persistent{
  LoginEntity({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory LoginEntity.fromJson(Map<String, dynamic> json) => LoginEntity(
    email: json["email"] == null ? null : json["email"],
    password: json["password"] == null ? null : json["password"],
  );

  @override
  Map<String, dynamic> toJson() => {
    "email": email == null ? null : email,
    "password": password == null ? null : password,
  };
}
