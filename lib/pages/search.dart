import 'package:flutter/material.dart';
import '../api_service.dart';
import 'cart_page.dart';
import 'home_page.dart';
import 'product.dart';
import '../models/product_model.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/favourite_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String currentPage = "Search";
  bool _isLoading = false;
  final TextEditingController _controller = TextEditingController();
  List<ProductModel> _searchResults = [];
  bool success = false;

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
          iconBuilder(Icon(Icons.search, color: Color(0xFF6055D8)), "Search"),
          iconBuilder(
            Icon(Icons.shopping_bag, color: Color(0xFF9E9E9E)),
            "Bag",
          ),
          iconBuilder(Icon(Icons.person, color: Color(0xFF9E9E9E)), "Account"),
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
                  MaterialPageRoute(builder: (context) => CartPage()),
                ),
              }
            else
              {
                if (label == "Home" && currentPage != "Home")
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(title: "Home"),
                      ),
                    ),
                  }
                else if (label == "Search" && currentPage != "Search")
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchPage()),
                    ),
                  },
              },
          },
          icon: icon,
        ),
      ],
    );
  }

  Widget cardBuilder(
    List<ProductModel> products,
    int index,
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
              width: 155,
              height: 134,
              child: Stack(
                children: [
                  SizedBox(
                    width: 155,
                    height: 134,
                    child: Image.network(
                      products[index].images![0],
                      width: 155,
                      height: 134,
                    ),
                  ),
                  Positioned(
                    left: 113,
                    top: 8,
                    child: IconButton(
                      onPressed: () => {
                        setState(() {
                          Provider.of<FavouriteProvider>(context, listen: false)
                              .addToFavourites(products[index]);
                        }),
                      },
                      icon: Icon(
                        !Provider.of<FavouriteProvider>(
                          context, listen: true
                          ).favourites.contains(products[index])
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
                          width: 50,
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
                    Spacer(),
                    SizedBox.square(
                      dimension: 24,
                      child: IconButton(
                        padding: EdgeInsets.only(right: 12),
                        constraints: BoxConstraints(),
                        onPressed: () {
                          Provider.of<CartProvider>(
                                        context,
                                        listen: false,
                                      ).addToCart(products[index], 1);
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
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Container(
                          width: 311,
                          height: 48,
                          decoration: BoxDecoration(color: Color(0xFFF8F7F7)),
                          child: TextField(
                            controller: _controller,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              suffixIcon: Icon(Icons.cancel),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color(0xFFF8F7F7),
                                  width: 0.1,
                                ),
                              ),
                            ),
                            onChanged: (value) async {
                              setState(() {
                                this._isLoading = true;
                              });
                              try {
                                final products = await ApiService()
                                    .SearchProducts(value);
              
                                setState(() {
                                  _searchResults = products;
                                  _isLoading = false;
                                  success = true;
                                });
                              } catch (e) {
                                setState(() {
                                  _isLoading = false;
                                });
                                print("Search failed: $e");
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16,),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      "Filter",
                      style: TextStyle(
                              color: Color(0xFF6055D8),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"
                            ),
                    ),
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Results for",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Color(0xFF817F7F),
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),
                          children: <TextSpan> [
                            TextSpan(
                              text: "“ ${_controller.text} “",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 14,
                            fontWeight: FontWeight.w600
                          ),
                            )
                          ]
                        ) 
                        ),
                        Spacer(),
                        Text(
                          "${_searchResults.length} Results Found",
                          style: TextStyle(
                            color: Color(0xFF6055D8),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Poppins"
                          ),
                        )
                  ],
                  ),
                  SizedBox(height: 16,),
                  Expanded(
                    child: ListView.builder(
                       itemCount: _searchResults.length,
                       itemBuilder: (context, index) {
                         int newIndex = index;
                    
                         if (index > 0) {
                           newIndex += index;
                         }
                         int secondIndex = newIndex + 1;
                         return Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             newIndex < _searchResults.length
                                 ? cardBuilder(
                                     _searchResults,
                                     newIndex,
                                   
                                   )
                                 : SizedBox(),
                             Spacer(),
                             secondIndex < _searchResults.length
                                 ? cardBuilder(
                                     _searchResults,
                                     secondIndex,
                                   )
                                 : SizedBox(),
                           ],
                         );
                       },
                     ),
                  ),
                  bottomBarBuilder(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
