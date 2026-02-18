import 'package:flutter/material.dart';


class CommonAppBar extends StatelessWidget {

  final bool isHome;
  final String title;
  final VoidCallback? onBack;

  const CommonAppBar({
    super.key,
    this.isHome = false,
    this.title = "",
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment:
        isHome
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,

        children: [

          // ================= HOME PAGE =================
          if (isHome) ...[

            const CircleAvatar(
              radius: 24,
              backgroundColor: Color(0xffF3D1B0),
              child: Icon(Icons.person, color: Colors.black),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning, Dewesh 👋",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "You have 5 tasks for today",
                    style:
                    TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ),

            buildCircleIcon(Icons.notifications_none),

          ]

          // ================= OTHER PAGES =================
          else ...[



            Center(
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),

            buildCircleIcon(Icons.more_horiz),

          ]
        ],
      ),
    );
  }

  static Widget buildCircleIcon(IconData icon) {
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
}
