import 'package:flutter/material.dart';
import 'pages/make_payment.dart';
import 'pages/get_your_order.dart';
import 'pages/choose_products_page.dart';

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
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;
  static late PageController controller;
  static const email = "123@example.com";
  static const password = "123456";

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _counter = 0;
  int _curr_page = 0;

  

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    MainPage.controller = PageController();
  }

  @override
  void dispose() {
    MainPage.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PageView(
        scrollDirection: Axis.horizontal,
        controller: MainPage.controller,
        children: [
          ChooseProductsPage(title: "Choose Products"),
          MakePaymentPage(title: "Make Payment"),
          GetYourOrderPage(title: "Get Your Order"),
        ],
      ),
    
    );
  }
}
