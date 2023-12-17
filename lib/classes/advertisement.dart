import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zagoffer/screens/cat_products_screen.dart';
import 'package:zagoffer/screens/man_products_screen.dart';
import 'package:zagoffer/screens/product_details_screen.dart';
import 'package:zagoffer/widgets/slider_item.dart';

class Advertisement {
  Advertisement({this.id, this.imageUrl, this.type});
  String? id;
  String? imageUrl;
  int? type;
}

class AdProvider with ChangeNotifier {
  List<Advertisement> _ads = [];
  List<Advertisement> get ads {
    return [..._ads];
  }

  List<SliderItem> sliderList = [];

  Future fetchAds(BuildContext context) async {
    final String url = 'https://zagoffer.com/cartapi/ad.php/?lang=2&code=10';
    try {
      var response = await http.get(Uri.parse(url));
      var jsonData = jsonDecode(response.body);
      List<Advertisement> fetchedAds = [];
      for (Map i in jsonData) {
        fetchedAds.insert(
          0,
          Advertisement(
            id: i['link'],
            imageUrl: 'https://zagoffer.com/s/image/${i['image']}',
            type: int.parse(i['sort_order']),
          ),
        );
      }
      _ads = fetchedAds;
      List<SliderItem> fetchedSliderList = [];
      for (Advertisement i in _ads) {
        fetchedSliderList.add(
          SliderItem(
            imageUrl: i.imageUrl,
            id: i.id,
            type: i.type,
            onPressed: () {
              if (i.type == 1) {
                Navigator.of(context)
                    .pushNamed(ProductDetails.routeName, arguments: i.id);
              } else if (i.type == 2) {
                Navigator.of(context)
                    .pushNamed(CatProductsScreen.routeName, arguments: i.id);
              } else if (i.type == 3) {
                Navigator.of(context)
                    .pushNamed(CompProductsScreen.routeName, arguments: i.id);
              }
            },
          ),
        );
      }
      sliderList = fetchedSliderList;
    } catch (e) {
      throw (e);
    }
  }
}
