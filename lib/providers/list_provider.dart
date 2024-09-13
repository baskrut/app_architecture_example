import 'package:app_architecture_example/models/product_model.dart';
import 'package:app_architecture_example/mok/mok_producs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListProvider extends ChangeNotifier {
  final List<String> _types = [];

  final List<ProductModel> _products = List.generate(mokProducts.length, (i) => ProductModel.fromMap(mokProducts[i]));

  List<ProductModel> currentProducts = [];

  void init() {
    currentProducts = _products;
  }

  bool _isOutOfStock = false;

  bool get isOutOfStock => _isOutOfStock;

  set isOutOfStock(bool val) {
    _isOutOfStock = val;
    getCurrentProducts();
    notifyListeners();
  }

  String? _filterType;

  String? get filterType => _filterType;

  set filterType(String? val) {
    _filterType = val;
    getCurrentProducts();
    notifyListeners();
  }

  List<String> getTypes() {
    if (_types.isEmpty) {
      for (int i = 0; i < _products.length; i++) {
        if (!_types.contains(_products[i].category)) {
          _types.add(_products[i].category);
        }
      }
    }
    return _types;
  }

  void sortByPrice() {
    currentProducts.sort((a, b) => a.price.compareTo(b.price));
    notifyListeners();
  }

  void sortByRating() {
    currentProducts.sort((a, b) => a.rating.compareTo(b.rating));
    notifyListeners();
  }

  void getCurrentProducts() {
    if (isOutOfStock) {
      currentProducts = [..._products.where((element) => element.category == (_filterType ?? element.category))];
    } else {
      currentProducts = [
        ..._products
            .where((element) => element.category == (_filterType ?? element.category) && element.inStock == true)
      ];
    }

    notifyListeners();
  }
}

final listProv = ChangeNotifierProvider<ListProvider>((ref) {
  return ListProvider();
});
