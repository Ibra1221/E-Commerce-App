import 'package:e_commerce_project/models/product_model.dart';
import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<ProductModel> _favourites = [];
  List<ProductModel> get favourites => _favourites;

  void addToFavourites(ProductModel product) {
    final existingIndex = _favourites.indexWhere(
      (item) => product.id == product.id,
    );

    if (existingIndex != -1) {
      _favourites.removeAt(existingIndex);
    } else {
      favourites.add(product);
    }
    notifyListeners();
  }
}
