import 'package:e_commerce_project/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String currentPage = "Bag";

  Widget bottomBarBuilder() {
    return Container(
      width: 375,
      height: 61,
      decoration: BoxDecoration(
        color: Color(0xFFF8F7F7),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          iconBuilder(Icon(Icons.home, color: Color(0xFF6055D8)),"Home"),
          iconBuilder(Icon(Icons.search, color: Color(0xFF9E9E9E)),"Search"),
          iconBuilder(Icon(Icons.shopping_bag, color: Color(0xFF9E9E9E)), "Bag"),
          iconBuilder(Icon(Icons.person, color: Color(0xFF9E9E9E)),"Account"),
        ],
      ),
    );
  }

  Widget iconBuilder(Icon icon, String label) {
    return Column(
      children: [
        IconButton(
          onPressed: () => {
            if (label == "Bag" && currentPage != "Bag")
              {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                ),
              }
              else{
                if(label == "Home" && currentPage != "Home"){
                  Navigator.pop(context)
                }
              }
          },
          icon: icon,
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black, 
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    IconButton(
                            icon: Icon(Icons.arrow_back),
                            style: IconButton.styleFrom(
                              backgroundColor: Color(0xFFF8F7F7),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                    Text(
                      "Cart",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {}, 
                      icon: Icon(Icons.more)
                      )
                    ],
                    )
                ],
              ),
              )
            ),
        ),
      )
      );
  }
}
