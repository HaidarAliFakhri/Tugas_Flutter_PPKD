import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/model/profil_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';

class EditProfileInstagramPage extends StatefulWidget {
  const EditProfileInstagramPage({super.key});

  @override
  State<EditProfileInstagramPage> createState() =>
      _EditProfileInstagramPageState();
}

class _EditProfileInstagramPageState extends State<EditProfileInstagramPage> {
  final nameC = TextEditingController();
  String email = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadCurrentUser();
  }

  void loadCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    ProfileModel p = await ApiService.getProfile(token);

    nameC.text = p.user?.name ?? "";
    email = p.user?.email ?? "";

    setState(() {});
  }

  void saveProfile() async {
    setState(() => loading = true);

    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    ProfileModel result = await ApiService.editProfile(token, nameC.text);

    setState(() => loading = false);

    if (result.user != null) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.message ?? "Gagal update")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: loading ? null : saveProfile,
            child: Text("Done", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            // Foto profil
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue[100],
                    child: Icon(Icons.person, size: 60, color: Colors.blue),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Change profile photo",
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // NAME FIELD (editable)
            _editField(label: "Name", controller: nameC),

            SizedBox(height: 20),

            // EMAIL FIELD (non editable)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  child: Text(
                    email,
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _editField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
