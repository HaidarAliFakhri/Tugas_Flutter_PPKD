class UserModel {
  int? id;
  String? name;
  String? email;
  String? createdAt;
  String? updatedAt;
  dynamic emailVerifiedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.emailVerifiedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
