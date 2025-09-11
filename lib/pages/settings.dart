import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:e_commerce_project/main.dart';
import 'package:mdi/mdi.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              30
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        style: IconButton.styleFrom(
                          animationDuration: Duration(milliseconds: 200),
                          backgroundColor: Color(0xFFF8F7F7),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Spacer(),
                      Center(
                        child: Text(
                          "Settings",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 150),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F7F7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox.square(
                            dimension: 80,
                            child: Image.asset(
                              "assets/images/no-user_17847670.png",
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            children: [
                              Text(
                                "None",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                MainPage.email,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF9B9999),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 0,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Color(0xFFCAC8C8), width: 1.0),
                      ),
                    ),
                  ),
                  Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.notifications),
                                SizedBox(width: 12),
                                Text(
                                  "Notification",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                      SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Icon(Icons.language),
                                  SizedBox(width: 12),
                                  Text(
                                    "Language",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "English",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(Icons.arrow_forward),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Icon(Icons.help_center_rounded),
                                  SizedBox(width: 12),
                                  Text(
                                    "Contact",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                      SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Icon(Icons.share),
                                  SizedBox(width: 12),
                                  Text(
                                    "Share App",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                      SizedBox(height: 48),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Icon(Mdi.informationVariant),
                                  SizedBox(width: 12),
                                  Text(
                                    "About Us",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
