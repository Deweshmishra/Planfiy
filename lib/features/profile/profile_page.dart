import 'package:flutter/material.dart';
import 'package:planify/common/appbar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xff0D1333),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0D1333),
              Color(0xff1B1F4A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [

                  CommonAppBar(
                    title: "My Profile",
                  ),

                  const SizedBox(height: 20),

                  buildProfileAvatar(),
                  const SizedBox(height: 16),

                  const Text(
                    "Ashok Kumar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "ashok@productivity.io",
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(height: 10),

                  buildPremiumBadge(),
                  const SizedBox(height: 20),

                  buildStatsCard(),
                  const SizedBox(height: 20),

                  buildSettingsList(),

                  buildSaveButton(),

                ],
              ),
            ),
          ),
        ),

      ),
    );
  }

  // ================= TOP BAR =================


  Widget buildCircleIcon(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.08),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  // ================= PROFILE AVATAR =================
  Widget buildProfileAvatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [

        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [
                Color(0xff4F6CFF),
                Color(0xff8F3CFF),
              ],
            ),
          ),
          child: const CircleAvatar(
            radius: 50,
            backgroundColor: Color(0xffE8BFA2),
            child: Icon(Icons.person, size: 40),
          ),
        ),

        Container(
          height: 30,
          width: 30,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent,
          ),
          child: const Icon(
            Icons.edit,
            size: 16,
            color: Colors.white,
          ),
        )

      ],
    );
  }

  // ================= PREMIUM BADGE =================
  Widget buildPremiumBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 18, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blueAccent,
        ),
      ),
      child: const Text(
        "PREMIUM MEMBER",
        style: TextStyle(
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  // ================= STATS CARD =================
  Widget buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: [

          buildStatItem("Tasks", "128"),
          buildStatItem("Done", "94"),
          buildStatItem("Score", "82%"),

        ],
      ),
    );
  }

  Widget buildStatItem(String title, String value) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.blueAccent)),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  // ================= SETTINGS LIST =================
  Widget buildSettingsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [

          buildSettingsRow(Icons.person, "Edit Profile"),
          buildSettingsRow(Icons.lock, "Change Password"),
          buildSettingsRow(Icons.notifications, "Notification Settings"),
          buildSettingsRow(Icons.palette, "App Theme"),
          buildSettingsRow(Icons.security, "Privacy Policy"),
          buildSettingsRow(Icons.help_outline, "Help & Support"),

          buildSettingsRow(Icons.logout, "Logout",
              isLogout: true),

        ],
      ),
    );
  }

  Widget buildSettingsRow(IconData icon,
      String title,
      {bool isLogout = false}) {

    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
        Colors.blueAccent.withOpacity(0.2),
        child: Icon(icon,
            color: isLogout
                ? Colors.red
                : Colors.blueAccent),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout
              ? Colors.red
              : Colors.white,
        ),
      ),
      trailing: const Icon(Icons.chevron_right,
          color: Colors.white54),
    );
  }

  // ================= SAVE BUTTON =================
  Widget buildSaveButton() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color(0xff4F6CFF),
            Color(0xff8F3CFF),
          ],
        ),
      ),
      child: const Center(
        child: Text(
          "Save Changes",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16),
        ),
      ),
    );
  }
}
