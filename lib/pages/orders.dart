import 'package:e_commerce_project/models/product_model.dart';
import 'package:flutter/material.dart';
import '../providers/orders_provider.dart';
import 'package:provider/provider.dart';
import 'product.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  @override
  Widget build(BuildContext context) {
    final ordersList = Provider.of<OrdersProvider>(context);
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
            child: Column(
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
                        Spacer(),
                        Center(
                          child: Text(
                            "Orders",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 150),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "Active",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              Container(
                                width: 54,
                                height: 2,
                                decoration: BoxDecoration(
                                  color: Color(0xFF6055D8),
                                  border: BoxBorder.all(width: 1)
                                ),
                              )
                            ],
                          ),
                        ),
                        Text(
                                "Completed",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                      itemCount: ordersList.orders.length,
                      itemBuilder: (context, index) {
                                          ProductModel order = ordersList.orders[index];
                      
                        return SizedBox(
                          width: 343,
                          height: 110,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                    title: "Product Page",
                                    product: order,
                                    index: ordersList.orders.indexOf(order),
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Color(0xFFF8F7F7),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 126,
                                    height: 99,
                                    child: Image.network(
                                      order.images![0],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: Text(
                                          order.title!,
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
                                      Text(
                                        order.brand ==
                                                null
                                            ? "No Official Brand"
                                            : order.brand!,
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
                                              "\$${order.price.toString()}",
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
                                          //Spacer(),
                                          SizedBox(width: 40,),
                                          TextButton(
                                            onPressed: (){}, 
                                            style: ButtonStyle(
                                              backgroundColor: WidgetStatePropertyAll(Color(0xFF6055D8))
                                            ),
                                            child: Text(
                                              "Track Order",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600
                                              ),
                                            )
                                            )
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
                    )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
