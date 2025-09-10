import 'package:e_commerce_project/models/product_model.dart';
import 'package:flutter/material.dart';

class TotalProductsProvider extends ChangeNotifier {
  List<ProductModel> _totalProducts = [];
  List<ProductModel> get totalProducts => _totalProducts;

  void setProducts(List<ProductModel> products) {
    _totalProducts = products;
    notifyListeners();
  }
}