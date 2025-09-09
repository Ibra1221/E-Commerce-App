import 'package:flutter/material.dart';
import '../main.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'login.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const GetYourOrderPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class GetYourOrderPage extends StatefulWidget {
  const GetYourOrderPage({super.key, required this.title});


  final String title;

  @override
  State<GetYourOrderPage> createState() => _GetYourOrderPageState();
}

class _GetYourOrderPageState extends State<GetYourOrderPage> {
  
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
                            text: "3",
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
                                  )
                                  ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () => {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(title: "Login"),
                            ),
                          ),
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
                          )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 51),
                      child: SizedBox(
                        width: 350,
                        height: 350,
                        child: Image.asset(
                          "assets/images/Shopping bag-rafiki 1.png"
                          ),
                      ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(top:15),
                      child: Text(
                        "Get Your Order",
                        style: TextStyle(
                          color: Colors.black, 
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Montserrat",
                          ),
                      ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(top:10),
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
                      )
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                              onPressed: () => {
                                MainPage.controller.previousPage(
                                  duration: Duration(milliseconds: 300), 
                                  curve: Curves.easeInOut)
                              },
                              child: Text(
                                  "Prev",
                                  style: TextStyle(
                                    color: Color(0xFFC4C4C4), 
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Montserrat",
                                    ),
                                ),
                              ),
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
                        TextButton(
                          onPressed: () => {
                            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(title: "Login"),
                            ),
                          ),
                          },
                          child: Text(
                              "Get Started",
                              style: TextStyle(
                                color: Color(0xFF7D76DE), 
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                                ),
                            ),
                          )
                      ],
                    )
                  ],
                  
                ),
              ),
            ),
          ),
        ),
      );

  }
}
