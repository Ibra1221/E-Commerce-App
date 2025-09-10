import 'package:e_commerce_project/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'orders.dart';
import '../providers/orders_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  Widget choiceBuilder(IconData company_icon, String label, bool selected) {
    return Row(
      children: [
        Icon(company_icon),
        Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : Color(0xFF686767),
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: selected
              ? Icon(Icons.check, color: Color(0xFF6055D8))
              : Icon(Icons.circle_outlined, color: Colors.white),
        ),
      ],
    );
  }

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    final ordersList = Provider.of<OrdersProvider>(context);
    final cart = Provider.of<CartProvider>(context);
    final paymentMethods = [
      {"icon": Icons.paypal, "label": "  PayPal"},
      {"icon": Icons.credit_card, "label": "  Credit Card"},
      {"icon": Icons.monetization_on, "label": "  Cash"},
    ];
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                      Expanded(
                        child: Center(
                          child: Text(
                            "Checkout",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(width: 50),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Mdi.mapMarkerRadius,
                          color: Color(0xFF6055D8),
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                      Column(
                        children: [
                          Text(
                            "325 15th Eighth Avenue, NewYork",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Saepe eaque fugiat ea voluptatum veniam.",
                            style: TextStyle(
                              color: Color(0xFF9B9999),
                              fontSize: 12,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.watch_later,
                          color: Color(0xFF6055D8),
                          size: 24,
                        ),
                        onPressed: () {},
                      ),
                      Text(
                        "6:00 pm, Wednesday 20",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 20),
                  Container(
                    width: 343,
                    height: 206,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFA9A6A6),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order Summary",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Items",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Color(0xFF484848),
                                    ),
                                  ),
                                  Text(
                                    cart.getProductsQuantity() > 9
                                        ? cart.getProductsQuantity().toString()
                                        : "0${cart.getProductsQuantity()}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Color(0xFF484848),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Color(0xFF484848),
                                    ),
                                  ),
                                  Text(
                                    "\$${cart.getTotalPrice().toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Color(0xFF484848),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Color(0xFF484848),
                                    ),
                                  ),
                                  Text(
                                    "\$${cart.getDiscount().toStringAsFixed(2)}",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Color(0xFF484848),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Delivery Charges",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Color(0xFF484848),
                                    ),
                                  ),
                                  Text(
                                    "\$0",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      color: Color(0xFF484848),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 343,
                          height: 0,
                          decoration: BoxDecoration(
                            color: Color(0xFFA9A6A6),
                            border: BoxBorder.all(width: 1),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color: Color(0xFF484848),
                                ),
                              ),
                              Text(
                                "\$${cart.getFinalPrice().toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                  color: Color(0xFF484848),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Choose Payment Method",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ...List.generate(paymentMethods.length, (index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: choiceBuilder(
                          paymentMethods[index]["icon"] as IconData,
                          paymentMethods[index]["label"] as String,
                          selectedIndex == index,
                        ),
                      ),
                    );
                  }),
                  Row(
                    children: [
                      Text(
                        "Add new payment method",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Poppins",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add, color: Color(0xFF6055D8)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 343,
                    height: 48,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xFF6055D8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          final itemsToOrder = List.from(cart.cartitems); // copy before modifying

                          for (final cartItem in itemsToOrder) {
                            ordersList.addToOrders(cartItem.product);
                            cart.removeFromCart(cartItem.product, cartItem.quantity);
                          }

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => OrdersPage()),
                        );
                        });
                      },
                      child: Text(
                        "Check Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
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
