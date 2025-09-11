import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../models/product_model.dart';
import 'products_list.dart';
import '../api_service.dart';
import 'error_page.dart';
import 'package:dio/dio.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  SfRangeValues _values = SfRangeValues(40.0, 80.0);
  int selectedGenderIndex = 0;
  List<int> selectedBrandsIndices = [];
  List<int> selectedColorsIndices = [];
  List<ProductModel> totalProducts = [];
  late Future<List<ProductModel>> _products;
  Future<Response>? _response;
  List<ProductModel> filteredProducts = [];
  bool _loaded = false;
  @override
  void initState() {
    super.initState();
    _response = ApiService().fetchProducts('/products');

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

    _products = ApiService().loadProducts();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
  try {
    totalProducts = await ApiService().loadProducts();
  } catch (e) {
    print("Error loading products: $e");
  } finally {
    setState(() {
      _loaded = true; // stop loading once done
    });
  }
}

  List<ProductModel> filter(
    final selectedBrandsIndices,
    SfRangeValues priceRange,
    final brands,
  ) {
    print(totalProducts.length);
    List selectedBrands = [];
    for (int i = 0; i < (selectedBrandsIndices as List).length; i++) {
      selectedBrands.add(brands[selectedBrandsIndices[i]]);
    }
    final start = priceRange.start;
    final end = priceRange.end;
    if (selectedBrands.isEmpty) {
      selectedBrands = brands;
    }
    final filteredProducts = totalProducts
        .where(
          (product) =>
              selectedBrands.contains(product.brand) &&
              (product.price! <= end && product.price! >= start),
        )
        .toList();
    for (int i = 0; i < totalProducts.length; i++) {
      print(totalProducts[i].brand);
    }
    return filteredProducts;
  }

  @override
  Widget build(BuildContext context) {
    final genderChoices = ["All", "Male", "Female"];
    final brands = [
      "Essence",
      "Glamour Beauty",
      "Velvet Touch",
      "Chic Cosmetics",
      "Nail Couture",
      "Calvin Klein",
      "Chanel",
      "Dior",
      "Dolce & Gabbana",
      "Gucci",
      "Annibale Colombo",
      "Furniture Co."
      "Knoll",
      "Bath Trends"
    ];
    final colors = ["White", "Black", "Grey", "Yellow", "Red", "Green"];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
           decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                  ),
          width: 375,
          height: 812,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                      Spacer(),
                      Center(
                        child: Text(
                          "Filter",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(width: 150),
                    ],
                  ),
                  SizedBox(height: 32),
                  Text(
                    "Gender",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(genderChoices.length, (index) {
                      return SizedBox(
                        width: 74,
                        height: 45,
                        child: TextButton(
                          
                          onPressed: () {
                            setState(() {
                              selectedGenderIndex = index;
                            });
                          },
                          style: TextButton.styleFrom(           
                            backgroundColor: selectedGenderIndex == index
                                ? Color(0xFF6055D8)
                                : Color(0xFFF8F7F7),
                            foregroundColor: selectedGenderIndex == index
                                ? Colors.white
                                : Color(0xFF9B9999),
                            animationDuration: Duration(milliseconds: 200),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            genderChoices[index],
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Brand",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    height: 170,
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(brands.length, (index) {
                          return SizedBox(
                            width: 107,
                            height: 45,
                            child: TextButton(
                              
                              onPressed: () {
                                setState(() {
                                  if (selectedBrandsIndices.contains(index)) {
                                    selectedBrandsIndices.remove(index);
                                  } else {
                                    selectedBrandsIndices.add(index);
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    selectedBrandsIndices.contains(index)
                                    ? Color(0xFF6055D8)
                                    : Color(0xFFF8F7F7),
                                foregroundColor:
                                    selectedBrandsIndices.contains(index)
                                    ? Colors.white
                                    : Color(0xFF9B9999),
                                animationDuration: Duration(milliseconds: 200),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text(
                                brands[index],
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Price Range",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SfRangeSlider(
                    values: _values,
                    max: 2500.00,
                    min: 0.00,
                    interval: 300,
                    enableTooltip: true,
                    //showLabels: true,
                    showTicks: true,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        _values = values;
                      });
                    },
                  ),
                  SizedBox(height: 44),
                  Text(
                    "Color",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(colors.length, (index) {
                      return SizedBox(
                        width: 107,
                        height: 45,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              if (selectedColorsIndices.contains(index)) {
                                selectedColorsIndices.remove(index);
                              } else {
                                selectedColorsIndices.add(index);
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                selectedColorsIndices.contains(index)
                                ? Color(0xFF6055D8)
                                : Color(0xFFF8F7F7),
                            foregroundColor:
                                selectedColorsIndices.contains(index)
                                ? Colors.white
                                : Color(0xFF9B9999),
                            animationDuration: Duration(milliseconds: 200),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            colors[index],
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 343,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFFF8F7F7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Another Option",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //SizedBox(height: 20,),
                  SizedBox(
                    width: 343,
                    height: 48,
                    child: TextButton(
                      
                      style: ButtonStyle(
                        animationDuration: Duration(milliseconds: 200),
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xFF6055D8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if(_loaded){
                            filteredProducts = filter(
                            selectedBrandsIndices,
                            _values,
                            brands,
                          );
                          print(filteredProducts);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductsListPage(
                                products: filteredProducts,
                                favourites: [],
                                title: "Filter Results",
                              ),
                            ),
                          );
                          }
                        });
                      },
                      child: Text(
                        "Apply Filter",
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
