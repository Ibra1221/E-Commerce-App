import 'package:e_commerce_project/main.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../api_service.dart';
import 'package:dio/dio.dart';
import 'error_page.dart';
import 'products_list.dart';
import '../providers/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'product.dart';
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
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _formKey = GlobalKey<FormState>();
  late Future<List<ProductModel>?> _products;
  late Future<List<ProductModel>?> _popularProducts;
  Future<Response>? _response;
  Future<Response>? _popularResponse;
  List<int> favouriteIndices = [];
  List<int> favouritePopularIndices = [];
  @override
  void initState() {
    super.initState();
    _response = ApiService().fetchProducts('/products');
    _popularResponse = ApiService().fetchProducts(
      '/products?sortBy=rating&order=desc',
    );

    _response!.then((response) {
      if (response.statusCode == 200) {
        print("Products fetched successfully");
      } else {
        print("Failed to fetch products: ${response.statusCode}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(),
            settings: RouteSettings(arguments: response.statusCode),
          ),
        );
      }
    });

    _popularResponse!.then((response) {
      if (response.statusCode == 200) {
        print("Popular products fetched successfully");
      } else {
        print("Failed to fetch popular products: ${response.statusCode}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ErrorPage(),
            settings: RouteSettings(arguments: response.statusCode),
          ),
        );
      }
    });
    _products = ApiService().loadProducts();
    _popularProducts = ApiService().loadPopularProducts();
  }

  Widget cardBuilder(
    List<ProductModel> products,
    int index,
    List<int> favourites,
  ) {
    return GestureDetector(
      onTap: () => {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductPage(
                  title: "Product", 
                  product: products[index],
                  favourites: favourites,
                  index: index,
                  ),

            ),
          );
        }),
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 126,
              height: 99,
              child: Stack(
                children: [
                  SizedBox(
                    width: 126,
                    height: 99,
                    child: Image.network(
                      products[index].images![0],
                      width: 126,
                      height: 99,
                    ),
                  ),
                  Positioned(
                    left: 84,
                    top: 8,
                    child: IconButton(
                          icon: !Provider.of<FavouriteProvider>(context, listen: true)
                          .favourites.contains(products[index])? 
                          Icon(Icons.favorite_border):
                          Icon(Icons.favorite) ,
                          style: IconButton.styleFrom(
                            backgroundColor: Color(0xFFF8F7F7),
                          ),
                          onPressed: () {
                            setState(() {
                              Provider.of<FavouriteProvider>(context, listen: false)
                                  .addToFavourites(products[index]);
                            });
                          },
                        ),
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 5)),
            Container(
              width: 126,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Color(0xFFF8F7F7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 21,
                      width: double.infinity,
                      child: Text(
                        products[index].title!,
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
                      width: double.infinity,
                      child: Text(
                        "\$${products[index].price!.toString()}",
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listBuilder(List<ProductModel> products, List<int> favourites) {
    return SizedBox(
      height: 173,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.isEmpty ? 0 : products.length,
        itemBuilder: (context, index) {
          return cardBuilder(products, index, favourites);
        },
      ),
    );
  }

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
          iconBuilder(Icon(Icons.home, color: Color(0xFF6055D8))),
          iconBuilder(Icon(Icons.search, color: Color(0xFF9E9E9E))),
          iconBuilder(Icon(Icons.shopping_bag, color: Color(0xFF9E9E9E))),
          iconBuilder(Icon(Icons.person, color: Color(0xFF9E9E9E))),
        ],
      ),
    );
  }

  Widget iconBuilder(Icon icon) {
    return IconButton(
      onPressed: () => {
        // if (label == "Bag")
        //   {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => CartPage(title: "Bag"),
        //       ),
        //     ),
        //   },
      },
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: 375,
          height: 812,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                SizedBox(
                                  height: 50,
                                  width: 170,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox.square(
                                        dimension: 24,
                                        child: Image.asset(
                                          "assets/images/no-user_17847670.png",
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: "Hello!\n",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: "Poppins",
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: MainPage.email,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Poppins",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 145),
                                  child: SizedBox(
                                    width: 17,
                                    height: 20,
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.notifications,
                                        color: Color(0xFF7C7979),
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 22),
                              child: Form(
                                key: _formKey,
                                child: Container(
                                  width: 343,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF8F7F7),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Color(0xFFF8F7F7),
                                          width: 0.1,
                                        ),
                                      ),

                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      labelText: "Search here",
                                      labelStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF9B9999),
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 54),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF6055D8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: 343,
                                height: 135,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: "Get Winter Discount\n",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: "      20% Off\n",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "     For Children",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: 89,
                                        height: 140,
                                        child: Image.asset(
                                          "assets/images/image 1.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Featured",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final products = await _products;
                                      if (products != null) {
                                        final featuredProducts = products
                                    .where(
                                      (product) =>
                                          product.rating! >=
                                              4.5 && // High rated
                                          product.price! <=
                                              500 && // Not too expensive
                                          product.stock! > 15, // Well stocked
                                    )
                                    .toList();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsListPage(
                                                  products: featuredProducts,
                                                  favourites: favouriteIndices,
                                                  title: "Featured",
                                                ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        color: Color(0xFF6055D8),
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder(
                              future: _products,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                }

                                final products = snapshot.data!;
                                final featuredProducts = products
                                    .where(
                                      (product) =>
                                          product.rating! >=
                                              4.5 && // High rated
                                          product.price! <=
                                              500 && // Not too expensive
                                          product.stock! > 50, // Well stocked
                                    )
                                    .toList();
                                return listBuilder(
                                  featuredProducts,
                                  favouriteIndices,
                                );
                              },
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 71),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Most Popular",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      final popularProducts = await _popularProducts;
                                      if (popularProducts != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductsListPage(
                                                  products: popularProducts,
                                                  favourites: favouritePopularIndices,
                                                  title: "Most Popular",
                                                ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "See All",
                                      style: TextStyle(
                                        color: Color(0xFF6055D8),
                                        fontFamily: "Poppins",
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            FutureBuilder(
                              future: _popularProducts,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                }

                                final products = snapshot.data!;
                                return listBuilder(
                                  products,
                                  favouritePopularIndices,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              bottomBarBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
