import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
//import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/classes/cart.dart';
import 'package:zagoffer/classes/orders_class.dart';
import 'package:zagoffer/classes/product_class.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/cart_screen.dart';
import 'package:zagoffer/screens/orders_screen.dart';
import 'package:zagoffer/widgets/badge.dart';
import 'package:zagoffer/widgets/details_button.dart';
import 'package:zagoffer/widgets/details_card.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';
import 'package:zagoffer/widgets/offers_widget.dart';
import 'package:zagoffer/widgets/title_widget.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = 'product_details';

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _scaffold = GlobalKey<ScaffoldState>();
  String? userId;
  String? userToken;
  bool isInit = true;
  bool? isLoading;
  late List productImageList;
  late List<Product> related;
  late Cart cart;
  // bool isFav;
  String? productId;
  Product? product;

  void getUserCreds() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      userId = _pref.getString('user_id');
      userToken = _pref.getString('userToken');
    });
  }

  void share(String productLink) async {
    await Share.share('$productLink');
  }

  @override
  void initState() {
    isLoading = true;
    getUserCreds();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit == true) {
      productId = ModalRoute.of(context)!.settings.arguments as String?;
      product = Provider.of<ProductsProvider>(context, listen: false)
          .allItems
          .firstWhere((prod) => prod.id == productId);
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchPrductImageList(productId, product!.imageUrl);
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchFavourites(context, userId, userToken);
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchRelated(productId);
      productImageList =
          Provider.of<ProductsProvider>(context, listen: false).prodImageSlider;
      related = Provider.of<ProductsProvider>(context, listen: false).related;
      cart = Provider.of<Cart>(context);
    }
    isInit = false;
    isLoading = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffold,
        drawer: MyDrawer(),
        body: isLoading == true
            ? Loading()
            : Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        leading: IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            _scaffold.currentState!.openDrawer();
                          },
                        ),
                        backgroundColor: Colors.white,
                        floating: false,
                        pinned: true,
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.33,
                        flexibleSpace: FlexibleSpaceBar(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset.zero,
                                      color: Colors.black12,
                                      blurRadius: 25,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.share_outlined,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    onPressed: () {
                                      share('https://zagoffer.com');
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset.zero,
                                      color: Colors.black12,
                                      blurRadius: 25,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Consumer<ProductsProvider>(
                                      builder: (context, prodProvider, ch) {
                                    bool isFav = prodProvider.favorites
                                        .contains(product);
                                    return IconButton(
                                      icon: Icon(
                                        isFav == true
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color:
                                            isFav == true ? red : Colors.white,
                                        size: 15,
                                      ),
                                      onPressed: () {
                                        Provider.of<ProductsProvider>(context,
                                                listen: false)
                                            .addFavorite(context, userId,
                                                userToken, productId);
                                      },
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                          background: productImageList.isEmpty
                              ? Text('')
                              : Carousel(
                                  dotBgColor: Colors.transparent,
                                  dotColor: Colors.grey,
                                  dotIncreasedColor: red,
                                  dotHorizontalPadding: 15.0,
                                  dotVerticalPadding: 10.0,
                                  dotPosition: DotPosition.bottomLeft,
                                  dotSize: 5.0,
                                  images: productImageList as List<Widget>,
                                ),
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: RichText(
                                  textDirection: TextDirection.rtl,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            '${product!.price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 25,
                                        ),
                                      ),
                                      product!.oldPrice == null
                                          ? TextSpan(text: '')
                                          : TextSpan(
                                              text: ' بدلا من ',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                fontSize: 25,
                                              ),
                                            ),
                                      product!.oldPrice == null
                                          ? TextSpan(text: '')
                                          : TextSpan(
                                              text: '${product!.oldPrice}',
                                              style: TextStyle(
                                                color: red,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontSize: 25,
                                              ),
                                            ),
                                      TextSpan(
                                        text: ' ج.م ',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          fontSize: 25,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  '${product!.name}',
                                  softWrap: true,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            DetailsCard(
                              title: 'تفاصيل المنتج',
                              details: product!.description,
                            ),
                            related.isEmpty
                                ? Text('')
                                : TitleWidget(
                                    title: 'ذات صلة',
                                  ),
                            related.isEmpty
                                ? Text('')
                                : Container(
                                    height: 220,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: related.length,
                                      itemBuilder: (context, i) => OffersWidget(
                                        imageUrl: related[i].imageUrl,
                                        productName: related[i].name,
                                        productPrice:
                                            related[i].price.toStringAsFixed(2),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pushNamed(
                                              ProductDetails.routeName,
                                              arguments: related[i].id);
                                        },
                                      ),
                                    ),
                                  ),
                            SizedBox(
                              height: 200,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    left: 0.0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              DetailsButton(
                                color: red,
                                text: 'أضف الي السلة',
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  topLeft: Radius.circular(50),
                                ),
                                onPressed: () {
                                  Provider.of<Cart>(context, listen: false)
                                      .addItem(
                                    productId: product!.id,
                                    imageUrl: product!.imageUrl,
                                    title: product!.name,
                                    price: product!.price,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                        'تم اضافة المنتج الي سلة التسوق الخاصة بك',
                                        textDirection: TextDirection.rtl,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              DetailsButton(
                                color: Colors.black87,
                                text: 'إشتري الاّن',
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                ),
                                onPressed: () {
                                  cart.addItem(
                                    productId: product!.id,
                                    imageUrl: product!.imageUrl,
                                    title: product!.name,
                                    price: product!.price,
                                  );
                                  Provider.of<Orders>(context, listen: false)
                                      .addOrder(cart.items.values.toList(),
                                          cart.totalCost);
                                  Navigator.of(context)
                                      .pushNamed(OrdersScreen.routeName);
                                },
                              ),
                            ],
                          ),
                          Consumer<Cart>(
                            builder: (context, cart, ch) => cart.itemCount == 0
                                ? IconButton(
                                    icon: Icon(
                                      Icons.shopping_cart_outlined,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(CartScreen.routeName);
                                    },
                                  )
                                : Badge(
                                    value: cart.itemCount.toString(),
                                    color: red,
                                    child: ch,
                                  ),
                            child: IconButton(
                              icon: Icon(
                                Icons.shopping_cart_outlined,
                                size: 35,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(CartScreen.routeName);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
