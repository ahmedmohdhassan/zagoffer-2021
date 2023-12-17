import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zagoffer/classes/product_class.dart';

class Company {
  Company({
    this.id,
    this.name,
    this.imageUrl,
  });

  String? id;
  String? name;
  String? imageUrl;
}

class CompaniesProvider with ChangeNotifier {
  List<Company> _companies = [];

  List<Company> get companies {
    return [..._companies];
  }

  List<Product> _compProducts = [];
  List<Product> get compProducts {
    return [..._compProducts];
  }

  Future fetchComps() async {
    final url = 'https://zagoffer.com/cartapi/manufactory.php/?lang=2';
    var response = await http.get(
      Uri.parse(url),
    );
    var jsonData = jsonDecode(response.body);
    print(jsonData);

    List<Company> fetchedComps = [];
    for (Map i in jsonData) {
      fetchedComps.insert(
        0,
        Company(
          id: i['manufacturer_id'],
          name: i['name'],
          imageUrl: 'https://zagoffer.com/s/image/${i['image']}',
        ),
      );
    }
    _companies = fetchedComps;
    notifyListeners();
  }

  Future fetchCompProducts(String? compId) async {
    final String url =
        'https://zagoffer.com/cartapi/products.php/?manufactory=$compId&lang=2';

    try {
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      List<Product> fetchedCompProducts = [];
      print(jsonData);
      for (Map i in jsonData) {
        fetchedCompProducts.insert(
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
      _compProducts = fetchedCompProducts;
      notifyListeners();
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
