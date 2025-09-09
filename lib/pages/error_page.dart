import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ErrorPage());
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    String? statusCode = ModalRoute.of(context)?.settings.arguments.toString();
    if (statusCode == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: Text('Error: No product data provided')),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
            ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.5),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 310),
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 140),
                      SizedBox(
                        width: 330,
                        height: 229,
                        child: Image.asset("assets/images/Mask Group (1).png"),
                      ),
                      SizedBox(height: 58),
                      Text(
                        statusCode,
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Roboto",
                          color: Color(0xFF302EA7),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 23),
                        child: RichText(
                          text: TextSpan(
                            text: "Something went wrong!\n",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Nunito",
                              color: Color(0xFF161719),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Please try again later.",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Nunito",
                                  color: Color(0xFF9B9B9B),
                                ),
                              ),
                            ],
                          ),
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
