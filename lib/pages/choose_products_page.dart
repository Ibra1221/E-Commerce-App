import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../main.dart';
import 'login.dart';

class ChooseProductsPage extends StatefulWidget {
  const ChooseProductsPage({super.key, required this.title});
  final String title;

  @override
  State<ChooseProductsPage> createState() => _ChooseProductsPageState();
}

class _ChooseProductsPageState extends State<ChooseProductsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
            ),
          width: 375,
          height: 812,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "1",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '/3',
                              style: TextStyle(
                                color: Color(0xFFA0A0A1),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                                animationDuration: Duration(milliseconds: 100)
                              ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  LoginPage(title: "Login"),
                              transitionDuration: Duration(milliseconds: 500),
                              transitionsBuilder: (_, animation, __, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 110),
                    child: SizedBox.square(
                      dimension: 300,
                      child: Image.asset(
                        "assets/images/fashion shop-rafiki 1.png",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(
                      "Choose Products",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.",
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: TextStyle(
                        color: Color(0xFFA8A8A9),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 147),
                    child: Row(
                      children: [
                        SmoothPageIndicator(
                          controller: MainPage.controller,
                          count: 3,
                          effect: ExpandingDotsEffect(
                            activeDotColor: Color(0xFF17223B),
                            dotColor: Color(0xFFD2D3D8),
                            dotHeight: 8,
                            dotWidth: 8,
                            spacing: 8,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          style: ButtonStyle(
                                animationDuration: Duration(milliseconds: 200)
                              ),
                          onPressed: () => {
                            MainPage.controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                          },
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: Color(0xFF7D76DE),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Montserrat",
                            ),
                          ),
                        ),
                      ],
                    ),
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
