import 'dart:convert';

import 'package:haidar_ppkd/tugas/day_33/tugas15/model/login_model.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/model/profil_model.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/model/register_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://absensib1.mobileprojp.com/api";

  // -----------------------------
  // REGISTER
  // -----------------------------
  static Future<RegisterModel> register(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Accept": "application/json"},
      body: {"name": name, "email": email, "password": password},
    );

    print("REGISTER RESPONSE: ${response.body}");

    return RegisterModel.fromJson(jsonDecode(response.body));
  }

  // -----------------------------
  // LOGIN
  // -----------------------------
  static Future<LoginModel> login(String email, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Accept": "application/json"},
      body: {"email": email, "password": password},
    );

    print("LOGIN RESPONSE: ${response.body}");

    return LoginModel.fromJson(jsonDecode(response.body));
  }

  // -----------------------------
  // GET PROFILE
  // -----------------------------
  static Future<ProfileModel> getProfile(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/profile"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );

    print("PROFILE RESPONSE: ${response.body}");

    return ProfileModel.fromJson(jsonDecode(response.body));
  }

  // -----------------------------
  // EDIT PROFILE
  // -----------------------------
  static Future<ProfileModel> editProfile(String token, String name) async {
    final url = Uri.parse("$baseUrl/profile");

    final response = await http.post(
      url,
      headers: {"Authorization": "Bearer $token", "Accept": "application/json"},
      body: {"_method": "PUT", "name": name},
    );

    print("EDIT RESPONSE: ${response.statusCode}");
    print("EDIT BODY: ${response.body}");

    return ProfileModel.fromJson(jsonDecode(response.body));
  }
}
