import 'user_model.dart';

class RegisterModel {
  String? message;
  String? token;
  UserModel? user;

  RegisterModel({this.message, this.token, this.user});

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    message: json["message"],
    token: json["data"]?["token"],
    user: json["data"]?["user"] == null
        ? null
        : UserModel.fromJson(json["data"]["user"]),
  );
}
