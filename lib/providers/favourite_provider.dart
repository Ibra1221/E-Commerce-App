import 'package:e_commerce_project/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FavouriteProvider extends ChangeNotifier {
  final List<ProductModel> _favourites = [];
  List<ProductModel> get favourites => _favourites;
  var box = Hive.box('favouritesBox');

  void getStoredFavourites() {
    if (box.isNotEmpty) {
      _favourites.clear();
      _favourites.addAll(
        box.get("favourites", defaultValue: []).cast<ProductModel>(),
      );
      notifyListeners();
    }
  }

  void setStoredFavourites() {
    box.put("favourites", _favourites);
  }

  void addToFavourites(ProductModel product) {
    final existingIndex = _favourites.indexWhere(
      (item) => item.id == product.id,
    );

    if (existingIndex != -1) {
      _favourites.removeAt(existingIndex);
    } else {
      _favourites.add(product);
    }
    setStoredFavourites();
    notifyListeners();
  }
}
