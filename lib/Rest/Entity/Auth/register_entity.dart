class RegisterEntity {
  RegisterEntity({
    this.name,
    this.email,
    this.password,
  });

  String? name;
  String? email;
  String? password;

  factory RegisterEntity.fromJson(Map<String, dynamic> json) => RegisterEntity(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
      };
}
