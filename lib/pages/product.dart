import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../providers/favourite_provider.dart';
import '../providers/favourite_provider.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    super.key,
    required this.title,
    required this.product,
    required this.favourites,
    required this.index,
  });
  final String title;
  final ProductModel product;
  final List<int> favourites;
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
                    padding: EdgeInsets.only(top: 64, left: 16),
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
            ],
          ),
        ),
      ),
    );
  }
}
