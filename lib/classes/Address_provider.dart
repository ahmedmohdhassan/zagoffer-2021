import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Country {
  Country({
    required this.id,
    required this.countryName,
  });
  String? countryName;
  String? id;
}

class Zone {
  Zone({
    required this.id,
    required this.zoneName,
    required this.countryId,
  });
  String? zoneName;
  String? countryId;
  String? id;
}

class AddressProvider with ChangeNotifier {
  List<Country> _countries = [];
  List<Country> get countries {
    return [..._countries];
  }

  List<Zone> _zones = [];
  List<Zone> get zones {
    return [..._zones];
  }

  Future fetchCountries() async {
    final String url = 'https://zagoffer.com/cartapi/country.php';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Country> fetchedCountries = [];
        for (Map i in jsonData) {
          fetchedCountries
              .add(Country(id: i['country_id'], countryName: i['name']));
        }
        _countries = fetchedCountries;
        notifyListeners();
      } else {
        print('Connection Error .............');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future fetchZones() async {
    final String url = 'https://zagoffer.com/cartapi/zone.php';
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Zone> fetchedZones = [];
        for (Map i in jsonData) {
          fetchedZones.add(Zone(
              id: i['zone_id'],
              zoneName: i['name'],
              countryId: i['country_id']));
        }
        _zones = fetchedZones;
        notifyListeners();
      } else {
        print('Connection Error ....');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
