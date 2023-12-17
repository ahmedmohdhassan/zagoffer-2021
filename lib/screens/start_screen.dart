import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/advertisement.dart';
import 'package:zagoffer/classes/api_handler.dart';
import 'package:zagoffer/classes/category_provider.dart';
import 'package:zagoffer/classes/companies.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/screens/home_screen.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';

class StartScreen extends StatefulWidget {
  static const routeName = 'start_screen';
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0)).then((_) {
      getData().then((_) {
        Navigator.of(context).pushReplacementNamed(HomePage.routeName);
      });
    });
    super.initState();
  }

  Future getData() async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts()
        .catchError((e) {
      errorBar(context);
      print(e);
    });
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchDiscounts(context)
        .catchError((e) {
      errorBar(context);
      print(e);
    });
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchFlashSale(context)
        .catchError((e) {
      errorBar(context);
      print(e);
    });
    await Provider.of<AdProvider>(context, listen: false)
        .fetchAds(context)
        .catchError((e) {
      errorBar(context);
      print(e);
    });
    await Provider.of<CategoryProvider>(context, listen: false)
        .fetchCats()
        .catchError((e) {
      errorBar(context);
      print(e);
    });
    await Provider.of<CompaniesProvider>(context, listen: false)
        .fetchComps()
        .catchError((e) {
      errorBar(context);
      print(e);
    });
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'images/logo.png',
              height: size.height * 0.50,
              width: size.width * 0.50,
            ),
            Loading(),
          ],
        ),
      ),
    );
  }
}
