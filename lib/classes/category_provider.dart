import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:zagoffer/classes/category_class.dart';
import 'package:http/http.dart' as http;
import 'package:zagoffer/classes/product_class.dart';

class CategoryProvider with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories {
    return [..._categories];
  }

  List<Product> _catProducts = [];
  List<Product> get catProducts {
    return [..._catProducts];
  }

  Future fetchCats() async {
    List<Category> items = [];
    final String url = 'https://zagoffer.com/cartapi/category.php/?lang=2';
    var response = await http.get(
      Uri.parse(url),
    );
    print(response.body);
    var jsonData = jsonDecode(response.body);

    for (Map i in jsonData) {
      items.insert(
        0,
        Category(
          id: i['category_id'],
          imageUrl: 'https://zagoffer.com/s/image/${i['image']}',
          title: i['name'],
        ),
      );
    }
    _categories = items;
    notifyListeners();
  }

  Future fetchCatProducts(String? catId) async {
    final url =
        'https://zagoffer.com/cartapi/products.php/?category=$catId&lang=2';

    try {
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      List<Product> fetchedCatProducts = [];
      for (Map i in jsonData) {
        fetchedCatProducts.insert(
          0,
          Product(
            id: i['product_id'],
            name: i['name'],
            description: i['description'],
            price: double.parse(i['price']),
            imageUrl: 'https://zagoffer.com/s/image/${i['image']}',
          ),
        );
      }
      _catProducts = fetchedCatProducts;
      notifyListeners();
    } catch (e) {
      throw (e);
    }
  }
}
