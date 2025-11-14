import 'user_model.dart';

class LoginModel {
  String? message;
  String? token;
  UserModel? user;

  LoginModel({this.message, this.token, this.user});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    message: json["message"],
    token: json["data"]?["token"],
    user: json["data"]?["user"] == null
        ? null
        : UserModel.fromJson(json["data"]["user"]),
  );
}
