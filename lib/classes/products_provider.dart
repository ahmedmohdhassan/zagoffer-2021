import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:zagoffer/classes/api_handler.dart';
import 'package:zagoffer/classes/product_class.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _flashSale = [];
  List<Product> get flashSale {
    return [..._flashSale];
  }

  List _discounts = [];
  List<Product> get discounts {
    return [..._discounts];
  }

  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get allItems {
    return [..._items, ..._flashSale, ..._discounts];
  }

  List<Product> _related = [];
  List<Product> get related {
    return [..._related];
  }

  List<Product> _favorites = [];
  List<Product> get favorites {
    return [..._favorites];
  }

  List<String?> _prodImages = [];
  List<String?> get prodImages {
    return [..._prodImages];
  }

  List<Image> _prodImageSlider = [];
  List<Image> get prodImageSlider {
    return [..._prodImageSlider];
  }

  Product? _singleProduct;
  Product get singleProduct {
    return _singleProduct!;
  }

  Future fetchProducts() async {
    final url = 'https://zagoffer.com/cartapi/products.php/?lang=2';

    try {
      var response = await http.get(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData != 0) {
          List<Product> fetchedProducts = [];
          for (Map i in jsonData) {
            fetchedProducts.insert(
              0,
              Product(
                id: i['product_id'],
                name: i['name'],
                description: i['description'],
                price: double.parse(i['price']),
                points: double.parse(i['points']),
                stockQuantity: double.parse(i['quantity']),
                imageUrl: 'https://zagoffer.com/s/image/${i['image']}',
              ),
            );
          }
          _items = fetchedProducts;
          notifyListeners();
        } else {
          print('An Error has occurred .......');
        }
      } else {
        print('Connection Error has occurred');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future fetchDiscounts(BuildContext context) async {
    final String url = 'https://zagoffer.com/cartapi/product_discount.php';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData != 0) {
          List<Product> fetchedDiscount = [];
          for (Map i in jsonData) {
            fetchedDiscount.insert(
              0,
              Product(
                id: i['product_id'],
                name: i['name'],
                description: i['description'],
                price: double.parse(i['price']),
                oldPrice: double.parse(i['old_price']),
                stockQuantity: double.parse(i['quantity']),
                points: double.parse(i['points']),
                prodModel: i['model'],
                discountBegin: i['date_start'],
                discountEnd: i['date_end'],
                imageUrl: 'https://zagoffer.com/s/image/${i['image']}',
              ),
            );
          }
          _discounts = fetchedDiscount;
          notifyListeners();
        } else {
          print('An Error has occurred .......');
        }
      } else {
        print('Connection Error has occurred .......');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future fetchFlashSale(BuildContext context) async {
    final String url = 'https://zagoffer.com/cartapi/product_special.php';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData != 0) {
          List<Product> fetchedFlash = [];
          for (Map i in jsonData) {
            fetchedFlash.insert(
              0,
              Product(
                id: i['product_id'],
                name: i['name'],
                description: i['description'],
                price: double.parse(i['price']),
                oldPrice: double.parse(i['old_price']),
                stockQuantity: double.parse(i['quantity']),
                points: double.parse(i['points']),
                prodModel: i['model'],
                discountBegin: i['date_start'],
                discountEnd: i['date_end'],
                imageUrl: 'https://zagoffer.com/s/image/${i['image']}',
              ),
            );
          }
          _flashSale = fetchedFlash;
          notifyListeners();
        } else {
          print('An Error has occurred .......');
        }
      } else {
        print('Connection Error has occurred .......');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future fetchRelated(String? productId) async {
    final String url =
        'http://zagoffer.com/cartapi/related.php/?product_id=$productId';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData != 0) {
          List<Product> fetchedRelated = [];
          for (Map i in jsonData) {
            fetchedRelated.insert(
              0,
              Product(
                  id: i['related_id'],
                  name: i['name'],
                  description: i['description'],
                  price: double.parse(i['old_price']),
                  imageUrl: 'https://zagoffer.com/s/image/${i['image']}'),
            );
          }
          _related = fetchedRelated;
          notifyListeners();
        }
      } else {
        print('connection error .....');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future fetchPrductImageList(String? productId, String? prodImageUrl) async {
    final String url =
        'http://zagoffer.com/cartapi/images.php/?product_id=$productId';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData != 0) {
          List<String?> fetchedLinks = [];
          for (Map i in jsonData) {
            String? imageUrl = i['image'];

            fetchedLinks.add('https://zagoffer.com/s/image/$imageUrl');
          }
          fetchedLinks.insert(0, prodImageUrl);
          _prodImages = fetchedLinks;
          List<Image> fetchedImageSlider = [];
          for (String? i in fetchedLinks) {
            Image prodImage = Image.network(
              i!,
              fit: BoxFit.contain,
            );
            fetchedImageSlider.add(prodImage);
          }
          _prodImageSlider = fetchedImageSlider;
          notifyListeners();
        } else {
          print('An Error Has Occurred ....');
        }
      } else {
        print('Connection Error ....');
      }
    } catch (e) {
      print(e);
    }
  }

  Future fetchFavourites(
      BuildContext context, String? id, String? token) async {
    final String url = 'https://zagoffer.com/cartapi/get_wishlist.php';
    var body = {
      'customer_id': id,
      'token': token,
    };
    try {
      var response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        List<Product> fetchedFavourites = [];
        if (jsonData != 0) {
          for (Map i in jsonData) {
            fetchedFavourites.insert(
              0,
              Product(
                id: i['product_id'],
                name: i['name'],
                description: i['description'],
                price: double.parse(i['old_price']),
                imageUrl: 'https://zagoffer.com/s/image/${i['image']}',
              ),
            );
          }
          _favorites = fetchedFavourites;
          notifyListeners();
        } else {
          errorBar(context);
        }
      } else {
        errorBar(context);
      }
    } catch (e) {
      print(e);
    }
  }

  Future addFavorite(BuildContext context, String? userId, String? userToken,
      String? productId) async {
    final String url = 'https://zagoffer.com/cartapi/wishlist.php';
    var body = {
      'customer_id': '$userId',
      'token': '$userToken',
      'product_id': '$productId'
    };
    try {
      var response = await http.post(Uri.parse(url), body: body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData != 0) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'تمت الإضافة لقائمة المفضلات',
              textDirection: TextDirection.rtl,
            ),
          ));
          notifyListeners();
        } else {
          errorBar(context);
        }
      } else {
        errorBar(context);
      }
    } catch (e) {
      print(e);
    }
  }
////////Fetch a single Product by id
  ///https://zagoffer.com/cartapi/products.php/?lang=2&product_id=34

  Future fetchSingleProduct(String? productId) async {
    final String url =
        'https://zagoffer.com/cartapi/products.php/?lang=2&product_id=$productId';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData != 0) {
          var product = Product(
            id: jsonData[0]['product_id'],
            name: jsonData[0]['name'],
            description: jsonData[0]['description'],
            price: double.parse(jsonData[0]['price']),
            points: double.parse(jsonData[0]['points']),
            stockQuantity: double.parse(jsonData[0]['quantity']),
            imageUrl: 'https://zagoffer.com/s/image/${jsonData[0]['image']}',
          );
          _singleProduct = product;
          notifyListeners();
        } else {
          print('an error has occured');
        }
      } else {
        print('connection error has occurred');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
