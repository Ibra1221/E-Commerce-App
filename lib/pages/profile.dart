import 'package:flutter/material.dart';
import '../main.dart';
import 'login.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'search.dart';
import 'settings.dart';
import 'package:hive/hive.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Widget bottomBarBuilder() {
    return Container(
      width: 375,
      height: 61,
      decoration: BoxDecoration(
        color: Color(0xFFF8F7F7),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          iconBuilder(Icon(Icons.home, color: Color(0xFF9E9E9E)), "Home"),
          iconBuilder(Icon(Icons.search, color: Color(0xFF9E9E9E)), "Search"),
          iconBuilder(
            Icon(Icons.shopping_bag, color: Color(0xFF9E9E9E)),
            "Bag",
          ),
          iconBuilder(Icon(Icons.person, color: Color(0xFF6055D8)), "Profile"),
        ],
      ),
    );
  }

  Widget iconBuilder(Icon icon, String label) {
    return Column(
      children: [
        IconButton(
          style: ButtonStyle(
                                animationDuration: Duration(milliseconds: 200)
                              ),
          onPressed: () => {
            if (label == "Bag" && currentPage != "Bag")
              {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  CartPage(),
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (_, animation, __, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                            ),
                ),
              }
            else
              {
                if (label == "Home" && currentPage != "Home")
                  {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  HomePage(title: "HomePage",),
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (_, animation, __, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                            ),
                    ),
                  }
                else if (label == "Search" && currentPage != "Search")
                  {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  SearchPage(),
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (_, animation, __, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                            ),
                    ),
                  }
                else
                  {
                    if (label == "Profile" && currentPage != "Profile")
                      {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  ProfilePage(),
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (_, animation, __, child) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                            ),
                        ),
                      },
                  },
              },
          },
          icon: icon,
        ),
      ],
    );
  }

  String currentPage = "Profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox.square(
                            dimension: 80,
                            child: Image.asset(
                              "assets/images/no-user_17847670.png",
                            ),
                          ),
                          Text(
                            "None",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            MainPage.email,
                            style: TextStyle(
                              color: Color(0xFF9B9999),
                              fontFamily: "Poppins",
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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
                                    Icon(Icons.person_sharp),
                                    SizedBox(width: 12),
                                    Text(
                                      "Profile",
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
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  SettingsPage(),
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (_, animation, __, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              },

                            ),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.settings),
                                        SizedBox(width: 12),
                                        Text(
                                          "Setting",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
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
                                      Icon(Icons.mail),
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
                                      Icon(Icons.help),
                                      SizedBox(width: 12),
                                      Text(
                                        "Help",
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
                          SizedBox(height: 141),
                          InkWell(
                            onTap: () {
                              Hive.box('myBox').put('isLoggedIn', false);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      LoginPage(title: "LoginPage"),
                                ),
                              );
                            },

                            child: Text(
                              "Sign Out",
                              style: TextStyle(
                                color: Color(0xFFF55F1F),
                                fontSize: 16,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              bottomBarBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
