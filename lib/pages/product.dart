import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../providers/favourite_provider.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.title,
    required this.product,
    required this.index,
  });
  final String title;
  final ProductModel product;
  final int index;
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount: product.images!.length,
                      itemBuilder: (context, index, realIndex) {
                        final image = product.images![index];
                        return Container(
                          height: 401,
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(height: 401, reverse: true),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          IconButton(
                            icon: !Provider.of<FavouriteProvider>(context, listen: true)
                            .favourites.contains(widget.product)? 
                            Icon(Icons.favorite_border):
                            Icon(Icons.favorite, color: Color(0xFF7C7979)) ,
                            style: IconButton.styleFrom(
                              backgroundColor: Color(0xFFF8F7F7),
                            ),
                            onPressed: () {
                              setState(() {
                                Provider.of<FavouriteProvider>(context, listen: false)
                                    .addToFavourites(widget.product);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Color(0xFFFFC107),
                                    size: 16,
                                  ),
                                  Text(
                                product.rating.toString(),
                                style: TextStyle(
                                  color: Color(0xFF7C7979),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins",
                                ),
                              ),
                              Text(
                                "   (${product.reviews!.length.toString()} Review)",
                                style: TextStyle(
                                  color: Color(0xFF7D7A7A),
                                  fontFamily: "Poppins",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600
                                ),
                              )
                              ],
                              )
                            ],
                          ),
                          Text(
                            "\$${product.price.toString()}",
                            style: TextStyle(
                              color: Color(0xFF6055D8),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ]
                      ),
                      SizedBox(height: 70),
                      Text(
                        "Description",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        product.description!,
                        style: TextStyle(
                          color: Color(0xFF9B9999),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(height: 100),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6055D8),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text(
                                "Buy Now",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ),                        
                          const SizedBox(width: 12),
                          ElevatedButton(
                            onPressed: () {
                              // Provider.of<CartProvider>(
                              //   context,
                              //   listen: false,
                              // ).addToCart(product, itemCounter);
                            },
                            style: ElevatedButton.styleFrom(
                              shape: const CircleBorder(),
                              backgroundColor: Colors.grey[200],
                              padding: const EdgeInsets.all(14),
                            ),
                            child: const Icon(IconlyBold.bag,
                                color: Color(0xFF9E9E9E)),
                          ),
                        ],
                      ),
                    ],
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
