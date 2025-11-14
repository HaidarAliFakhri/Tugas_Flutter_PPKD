import 'package:flutter/material.dart';
import 'package:haidar_ppkd/tugas/day_33/tugas15/model/profil_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';

class ProfileInstagramPage extends StatefulWidget {
  const ProfileInstagramPage({super.key});

  @override
  State<ProfileInstagramPage> createState() => _ProfileInstagramPageState();
}

class _ProfileInstagramPageState extends State<ProfileInstagramPage> {
  late Future<ProfileModel> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = loadProfile(); // load pertama
  }

  Future<ProfileModel> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    return ApiService.getProfile(token);
  }

  void logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("token");
    Navigator.pushReplacementNamed(context, "/login");
  }

  // ------------------ REFRESH DATA ------------------
  void refreshProfile() {
    setState(() {
      futureProfile = loadProfile(); // panggil ulang API
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.black),
            onPressed: () => logout(context),
          ),
        ],
      ),

      body: FutureBuilder(
        future: futureProfile,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data!.user!;

          return SingleChildScrollView(
            child: Column(
              children: [
                // ------------------ PROFILE SECTION + USER INFO ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // FOTO PROFIL (Kiri)
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.blue[100],
                            child: Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.blue,
                            ),
                          ),

                          SizedBox(width: 20),

                          // POSTS - FOLLOWERS - FOLLOWING (Kanan)
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildCount("Posts", "12"),
                                _buildCount("Followers", "836"),
                                _buildCount("Following", "112"),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 16),

                      // NAMA USER
                      Text(
                        user.name ?? "",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      // EMAIL USER
                      Text(
                        user.email ?? "",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),

                      SizedBox(height: 20),
                    ],
                  ),
                ),

                // ------------------ EDIT & SHARE SIDE BY SIDE ------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      // ====== EDIT PROFILE BUTTON ======
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/edit").then((_) {
                              refreshProfile(); // refresh setelah edit
                            });
                          },
                          child: Text("Edit Profile"),
                        ),
                      ),

                      SizedBox(width: 10),

                      // ====== SHARE PROFILE BUTTON ======
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            final shareText =
                                """
                              ✨ Profil Saya ✨

                              Nama: ${user.name}
                              Email: ${user.email}

                              Dibagikan dari aplikasi Flutter saya 😎🔥
                                          """;

                            Share.share(shareText);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.share, size: 18),
                              SizedBox(width: 6),
                              Text("Bagikan"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ------------------ STORY HIGHLIGHTS ------------------
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                  child: SizedBox(
                    height: 110,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildStoryHighlight(
                          "My Story",
                          "https://picsum.photos/200?1",
                        ),
                        _buildStoryHighlight(
                          "Travel",
                          "https://picsum.photos/200?2",
                        ),
                        _buildStoryHighlight(
                          "Food",
                          "https://picsum.photos/200?3",
                        ),
                        _buildStoryHighlight(
                          "Friends",
                          "https://picsum.photos/200?4",
                        ),
                        _buildStoryHighlight(
                          "Campus",
                          "https://picsum.photos/200?5",
                        ),
                        _buildStoryHighlight(
                          "Family",
                          "https://picsum.photos/200?6",
                        ),
                      ],
                    ),
                  ),
                ),
                // ------------------ ICON MENU (Instagram Tabs) ------------------
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildIconMenu(Icons.grid_on, "Posts"),
                      _buildIconMenu(Icons.play_circle_outline, "Reels"),
                      _buildIconMenu(Icons.bookmark_border, "Saved"),
                      _buildIconMenu(Icons.person_pin_outlined, "Tagged"),
                    ],
                  ),
                ),

                // ------------------ GRID POSTS ------------------
                _buildGridPosts(),
                SizedBox(height: 30),
              ],
            ),
          );
        },
      ),
    );
  }

  // COUNT BOX ala Instagram
  Widget _buildCount(String title, String count) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(title, style: TextStyle(fontSize: 14, color: Colors.black54)),
      ],
    );
  }

  // GRID FOTO RANDOM (Instagram style)
  Widget _buildGridPosts() {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 30,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
      ),
      itemBuilder: (context, index) {
        return Container(
          color: Colors.grey[300],
          child: Image.network(
            "https://picsum.photos/200?random=$index",
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

Widget _buildStoryHighlight(String title, String imageUrl) {
  return Padding(
    padding: const EdgeInsets.only(right: 16),
    child: Column(
      children: [
        // FOTO CIRCLE
        CircleAvatar(radius: 35, backgroundImage: NetworkImage(imageUrl)),

        SizedBox(height: 6),

        // NAMA STORY
        Text(title, style: TextStyle(fontSize: 13)),
      ],
    ),
  );
}

Widget _buildIconMenu(IconData icon, String label) {
  return Column(
    children: [
      Icon(icon, size: 28, color: Colors.black87),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 12, color: Colors.black87)),
    ],
  );
}
