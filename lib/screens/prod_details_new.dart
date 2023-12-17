import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/classes/cart.dart';
import 'package:zagoffer/classes/product_class.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/cart_screen.dart';
import 'package:zagoffer/widgets/badge.dart';
import 'package:zagoffer/widgets/details_card.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';

class ProductDetailsNew extends StatefulWidget {
  static const routeName = 'prod_det_new';
  const ProductDetailsNew({Key? key}) : super(key: key);

  @override
  State<ProductDetailsNew> createState() => _ProductDetailsNewState();
}

class _ProductDetailsNewState extends State<ProductDetailsNew> {
  bool? isLoading;
  String? productId;
  Product? _product;
  bool? isFavorite;
  String? userId;
  String? userToken;
  List<Image>? prodImages;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    checkFav();
    Future.delayed(Duration(milliseconds: 0)).then((_) {
      productId = ModalRoute.of(context)!.settings.arguments as String;
      _product = Provider.of<ProductsProvider>(context, listen: false)
          .allItems
          .firstWhere((prod) => prod.id == productId);

      Provider.of<ProductsProvider>(context, listen: false)
          .fetchPrductImageList(productId, _product!.imageUrl)
          .then((_) => Provider.of<ProductsProvider>(context, listen: false)
                  .fetchRelated(productId)
                  .then((_) {
                setState(() {
                  isLoading = false;
                });
              }));
    });
    super.initState();
  }

  void getUserCreds() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      userToken = _prefs.getString('userToken');
      userId = _prefs.getString('user_id');
    });
  }

  void checkFav() {
    getUserCreds();
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchFavourites(context, userId, userToken);
    List<Product> favorites =
        Provider.of<ProductsProvider>(context, listen: false).favorites;
    if (favorites.contains(_product)) {
      setState(() {
        isFavorite = true;
      });
    } else {
      setState(() {
        isFavorite = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final related =
        Provider.of<ProductsProvider>(context, listen: false).related;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        body: isLoading == true
            ? Loading()
            : Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              width: double.infinity,
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '${_product!.name}',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text(
                                    _product!.oldPrice == null
                                        ? ''
                                        : '${_product!.oldPrice} ج.م',
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: _product!.oldPrice == null
                                          ? Colors.green
                                          : red,
                                      fontWeight: FontWeight.bold,
                                      decoration: _product!.oldPrice == null
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough,
                                    ),
                                    textDirection: TextDirection.rtl,
                                  ),
                                  Text(
                                    '${_product!.price} ج.م',
                                    textDirection: TextDirection.rtl,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Colors.teal,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              height: size.height * 0.50,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Carousel(
                                    images: Provider.of<ProductsProvider>(
                                            context,
                                            listen: false)
                                        .prodImageSlider,
                                    dotColor: Colors.grey,
                                    dotIncreasedColor: red,
                                    dotBgColor: Colors.transparent,
                                    dotSize: 6.0,
                                    dotPosition: DotPosition.bottomLeft,
                                  ),
                                  _product!.oldPrice == null
                                      ? Center()
                                      : Banner(
                                          message: 'Sale',
                                          location: BannerLocation.topStart,
                                        ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Share.share(
                                                'https://zagoffer.com/cartapi/products.php/?lang=2&product_id=${_product!.id}');
                                          },
                                          icon: Icon(
                                            Icons.share,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Provider.of<ProductsProvider>(
                                                    context,
                                                    listen: false)
                                                .addFavorite(context, userId,
                                                    userToken, productId)
                                                .catchError((e) {
                                              print(e);
                                            }).then((_) {
                                              setState(() {
                                                isFavorite = true;
                                              });
                                            });
                                          },
                                          icon: Icon(
                                            isFavorite == true
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: isFavorite == true
                                                ? red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  DetailsCard(
                                    title: 'الحالة',
                                    details: _product!.stockQuantity == 0
                                        ? 'غير متوفر حاليا'
                                        : 'متوفر',
                                  ),
                                  DetailsCard(
                                    title: 'النقاط',
                                    details: '${_product!.points}',
                                  ),
                                  DetailsCard(
                                    title: 'التفاصيل',
                                    details: _product!.description,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Container(
                                      height: 100,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: related.length,
                                        itemBuilder: (context, i) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3.0, horizontal: 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pushNamed(
                                                ProductDetailsNew.routeName,
                                                arguments: related[i].id,
                                              );
                                            },
                                            child: Container(
                                              width: size.width * 0.45,
                                              height: size.width * 0.15,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                                color: Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Image.network(
                                                        related[i].imageUrl!,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            related[i].name!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                          Text(
                                                              '${related[i].price}'),
                                                          Icon(
                                                            Icons
                                                                .add_shopping_cart_outlined,
                                                            color: Colors.blue,
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: GestureDetector(
                      onTap: () {
                        Provider.of<Cart>(context, listen: false).addItem(
                          productId: _product!.id,
                          imageUrl: _product!.imageUrl,
                          title: _product!.name,
                          price: _product!.price,
                        );
                      },
                      child: Container(
                        height: size.height * 0.09,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Consumer<Cart>(
                                builder: (context, cart, ch) =>
                                    cart.itemCount == 0
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.shopping_cart_outlined,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  CartScreen.routeName);
                                            },
                                          )
                                        : Badge(
                                            value: cart.itemCount.toString(),
                                            color: Colors.orange,
                                            child: ch,
                                          ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(CartScreen.routeName);
                                  },
                                ),
                              ),
                              Text(
                                'أضف الى سلة التسوق',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
