import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/product_details_screen.dart';
import 'package:zagoffer/widgets/error_widget.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class FavoritesScreen extends StatefulWidget {
  static const routeName = 'fav_screen';

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String? userId;
  String? userToken;
  bool isInit = true;

  void getUserCreds() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      userId = _pref.getString('user_id');
      userToken = _pref.getString('userToken');
    });
  }

  @override
  void initState() {
    if (isInit) {
      getUserCreds();
    }
    Future.delayed(Duration(milliseconds: 1)).then((_) {
      setState(() {
        isInit = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'المفضلة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Center(
          child: userId == null || userToken == null
              ? Loading()
              : FutureBuilder(
                  future: Provider.of<ProductsProvider>(context, listen: false)
                      .fetchFavourites(context, userId, userToken),
                  builder: (context, snapShot) {
                    Widget result;
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      result = Loading();
                    } else if (snapShot.hasError) {
                      result = FutureErrorWidget();
                    } else {
                      result = Consumer<ProductsProvider>(
                        builder: (context, prodData, ch) => prodData
                                .favorites.isEmpty
                            ? Text('قائمة المفضلات فارغة')
                            : Directionality(
                                textDirection: TextDirection.rtl,
                                child: ListView.builder(
                                  itemCount: prodData.favorites.length,
                                  itemBuilder: (context, i) => Card(
                                    elevation: 3,
                                    child: ListTile(
                                      isThreeLine: true,
                                      leading: Image.network(
                                        prodData.favorites[i].imageUrl!,
                                        fit: BoxFit.contain,
                                      ),
                                      title: Text(
                                        '${prodData.favorites[i].name}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${prodData.favorites[i].price} ج.م',
                                        style: TextStyle(
                                          color: Colors.teal,
                                        ),
                                      ),
                                      trailing: Icon(
                                        Icons.more_horiz,
                                        color: white,
                                      ),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          ProductDetails.routeName,
                                          arguments: prodData.favorites[i].id,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                      );
                    }

                    return result;
                  },
                ),
        ),
      ),
    );
  }
}
