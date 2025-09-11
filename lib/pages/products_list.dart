import 'package:e_commerce_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'product.dart';
import 'package:provider/provider.dart';
import '../providers/favourite_provider.dart';
import '../providers/cart_provider.dart';

class ProductsListPage extends StatefulWidget {
  final List<ProductModel> products;
  final List<int> favourites;
  final String title;
  const ProductsListPage({
    super.key,
    required this.products,
    required this.favourites,
    required this.title,
  });

  @override
  State<ProductsListPage> createState() => ProductsListPageState();
}

class ProductsListPageState extends State<ProductsListPage> {
  Widget cardBuilder(
    List<ProductModel> products,
    int index,
  ) {

    bool isFavourited = Provider.of<FavouriteProvider>(
                                context,
                                listen: true,
                              ).favourites.any(
                                (item) => item.id == products[index].id,
                              );
    return GestureDetector(
      onTap: () => {
        setState(() {
          Navigator.push(
            context,
            PageRouteBuilder(
                              pageBuilder: (_, __, ___) =>
                                  ProductPage(
                                    title: "Product Page",
                                    product: products[index],
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
        }),
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 155,
              height: 134,
              child: Stack(
                children: [
                  SizedBox(
                    width: 155,
                    height: 134,
                    child: Image.network(
                      widget.products[index].images![0],
                      width: 155,
                      height: 134,
                    ),
                  ),
                  Positioned(
                    left: 113,
                    top: 8,
                    child: IconButton(
                      style: ButtonStyle(
                                animationDuration: Duration(milliseconds: 200)
                              ),
                      onPressed: () {
                          setState(() {
                            isFavourited =
                              Provider.of<FavouriteProvider>(
                                context,
                                listen: false,
                              ).favourites.any(
                                (item) => item.id == products[index].id,
                              );
                          Provider.of<FavouriteProvider>(
                            context,
                            listen: false,
                          ).addToFavourites(products[index]);
                          });
                        
                      },
                      icon: Icon(
                        !isFavourited
                            ? Icons.favorite_border
                            : Icons.favorite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: 155,
              height: 64,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color(0xFFF8F7F7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 21,
                          width: 50,
                          child: Text(
                            widget.products[index].title!,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 18,
                          width: 50,
                          child: Text(
                            "\$${widget.products[index].price!.toString()}",
                            style: TextStyle(
                              color: Color(0xFF6055D8),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox.square(
                      dimension: 24,
                      child: IconButton(
                        style: ButtonStyle(
                                animationDuration: Duration(milliseconds: 200)
                              ),
                        padding: EdgeInsets.only(right: 12),
                        constraints: BoxConstraints(),
                        onPressed: () {
                          Provider.of<CartProvider>(
                                        context,
                                        listen: false,
                                      ).addToCart(widget.products[index], 1);
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Color(0xFF6055D8),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
              ),
            width: 375,
            height: 812,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        style: IconButton.styleFrom(
                          animationDuration: Duration(milliseconds: 200),
                          backgroundColor: Color(0xFFF8F7F7),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 80),
                        child: Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.products.length,
                      itemBuilder: (context, index) {
                        int newIndex = index;

                        if (index > 0) {
                          newIndex += index;
                        }
                        int secondIndex = newIndex + 1;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            newIndex < widget.products.length
                                ? cardBuilder(
                                    widget.products,
                                    newIndex,
                                  )
                                : SizedBox(),
                            Spacer(),
                            secondIndex < widget.products.length
                                ? cardBuilder(
                                    widget.products,
                                    secondIndex,
                                  )
                                : SizedBox(),
                          ],
                        );
                      },
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
