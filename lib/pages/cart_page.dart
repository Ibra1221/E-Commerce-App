import 'package:e_commerce_project/models/cart_item_model.dart';
import 'package:e_commerce_project/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'checkout.dart';
import 'search.dart';
import 'profile.dart';
import 'home_page.dart';

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
          iconBuilder(Icon(Icons.home, color: Color(0xFF9E9E9E)), "Home"),
          iconBuilder(Icon(Icons.search, color: Color(0xFF9E9E9E)), "Search"),
          iconBuilder(
            Icon(Icons.shopping_bag, color: Color(0xFF6055D8)),
            "Bag",
          ),
          iconBuilder(Icon(Icons.person, color: Color(0xFF9E9E9E)), "Profile"),
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
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 751,
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              
                              icon: Icon(Icons.arrow_back),
                              style: IconButton.styleFrom(
                                backgroundColor: Color(0xFFF8F7F7),
                                animationDuration: Duration(milliseconds: 200)
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
                              style: ButtonStyle(
                                animationDuration: Duration(milliseconds: 200)
                              ),
                              onPressed: () {},
                              icon: Icon(Icons.more_vert_rounded),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 343,
                          height: 380,
                          child: ListView.builder(
                            itemCount: cart.cartitems.length,
                            itemBuilder: (context, index) {
                              CartItem item = cart.cartitems[index];
                              int itemCounter = item.quantity;
                              return SizedBox(
                                width: 343,
                                height: 110,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  ProductPage(
                                    title: "Product Page",
                                    product: item.product,
                                    index: index,
                                    ),
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
                                  child: Card(
                                    color: Color(0xFFF8F7F7),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 126,
                                              height: 99,
                                              child: Image.network(
                                                cart
                                                    .cartitems[index]
                                                    .product
                                                    .images![0],
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        cart
                                                            .cartitems[index]
                                                            .product
                                                            .title!,
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      style: ButtonStyle(
                                animationDuration: Duration(milliseconds: 200)
                              ),
                                                      onPressed: () {
                                                        setState(() {
                                                          cart.removeFromCart(
                                                            cart
                                                                .cartitems[index]
                                                                .product,
                                                            cart
                                                                .cartitems[index]
                                                                .quantity,
                                                          );
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.delete_sharp,
                                                        color: Color(0xFFF78989),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  cart
                                                              .cartitems[index]
                                                              .product
                                                              .brand ==
                                                          null
                                                      ? "No Official Brand"
                                                      : cart
                                                            .cartitems[index]
                                                            .product
                                                            .brand!,
                                                  style: TextStyle(
                                                    color: Color(0xFF9B9999),
                                                    fontFamily: "Poppins",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 75,
                                                      child: Text(
                                                        "\$${item.product.price.toString()}",
                                                        style: TextStyle(
                                                          color: Color(0xFF6055D8),
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: "Poppins",
                                                        ),
                                                        overflow:
                                                            TextOverflow.ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    SizedBox(width: 30),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (item.quantity > 1) {
                                                                item.quantity--;
                                                              }
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.remove_circle,
                                                            size: 24,
                                                            color: Color(0xFF6055D8),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12),
                                                        Text(
                                                          itemCounter.toString(),
                                                          style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (item.quantity <
                                                                  99) {
                                                                item.quantity++;
                                                              }
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.add_circle,
                                                            size: 24,
                                                            color: Color(0xFF6055D8),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: 343,
                          height: 206,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF8F7F7)
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
                        SizedBox(
                          width: 343,
                          height: 48,
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                Color(0xFF6055D8),
                              ),
                              animationDuration: Duration(milliseconds: 200)
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutPage(),
                                ),
                              );
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
              bottomBarBuilder()
            ],
          ),
        ),
      ),
    );
  }
}
