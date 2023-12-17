import 'dart:io';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/advertisement.dart';
import 'package:zagoffer/classes/cart.dart';
import 'package:zagoffer/classes/category_provider.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/cart_screen.dart';
import 'package:zagoffer/screens/cat_products_screen.dart';
import 'package:zagoffer/screens/prod_details_new.dart';

//import 'package:zagoffer/screens/product_details_screen.dart';

import 'package:zagoffer/screens/search_screen.dart';
import 'package:zagoffer/widgets/badge.dart';
import 'package:zagoffer/widgets/flashsalebar.dart';
import 'package:zagoffer/widgets/myDrawer.dart';
import 'package:zagoffer/widgets/product_item.dart';
import 'package:zagoffer/widgets/title_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home_screen2';
  Future<void> refresh() {
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (() => showDialog(
            context: context,
            builder: (context) => Directionality(
              textDirection: TextDirection.rtl,
              child: AlertDialog(
                content: Text(
                  'هل تريد الخروج ؟',
                  style: TextStyle(
                    fontFamily: 'Tajawal',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      exit(0);
                    },
                    child: Text(
                      'نعم',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
                        color: red,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'لا',
                      style: TextStyle(
                        fontFamily: 'Tajawal',
                        fontWeight: FontWeight.bold,
                        color: red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ).then((value) => value as bool)),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'images/logo.png',
              height: 45,
              width: 45,
            ),
            actions: [
              Consumer<Cart>(
                builder: (context, cart, ch) => cart.itemCount == 0
                    ? IconButton(
                        icon: Icon(Icons.shopping_cart_outlined),
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreen.routeName);
                        },
                      )
                    : Badge(
                        value: cart.itemCount.toString(),
                        color: Colors.orange,
                        child: ch,
                      ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
            ],
          ),
          drawer: MyDrawer(),
          floatingActionButton: FloatingActionButton(
            backgroundColor: red,
            child: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(SearchScreen.routeName);
            },
          ),
          body: RefreshIndicator(
            displacement: 100,
            backgroundColor: Colors.white,
            color: red,
            onRefresh: refresh,
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      SizedBox(height: 15),
                      AdsBanner(),
                      CategorySelector(),
                      FlashSaleBar(),
                      DiscountsHomeWidget(),
                      TitleWidget(
                        title: 'وصل حديثاً',
                        chipText: 'جديد',
                      ),
                    ],
                  ),
                ),
                NewArrivals()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AdsBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future:
            Provider.of<AdProvider>(context, listen: false).fetchAds(context),
        builder: (context, snapShot) {
          Widget result;
          if (snapShot.connectionState == ConnectionState.waiting) {
            result = Text('');
          } else if (snapShot.hasError) {
            result = Text('');
          } else {
            result = Consumer<AdProvider>(
              builder: (context, adData, ch) => adData.sliderList.isEmpty
                  ? Text('')
                  : Container(
                      height: 120,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Carousel(
                        dotBgColor: Colors.transparent,
                        dotColor: Colors.transparent,
                        dotIncreasedColor: Colors.transparent,
                        dotHorizontalPadding: 0.0,
                        dotVerticalPadding: 0.0,
                        dotPosition: DotPosition.bottomLeft,
                        dotSize: 0.0,
                        boxFit: BoxFit.none,
                        images: adData.sliderList,
                      ),
                    ),
            );
          }
          return result;
        },
      ),
    );
  }
}

class CategorySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future:
            Provider.of<CategoryProvider>(context, listen: false).fetchCats(),
        builder: (context, snapShot) {
          Widget result;
          if (snapShot.connectionState == ConnectionState.waiting) {
            result = Text('');
          } else if (snapShot.hasError) {
            result = Text('');
          } else {
            result = Consumer<CategoryProvider>(
              builder: (context, catData, ch) => catData.categories.isEmpty
                  ? Text('')
                  : Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            child: Text(
                              'تسوق الأقسام',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          height: 125,
                          child: Center(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: catData.categories.length,
                              itemBuilder: (context, i) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    CatProductsScreen.routeName,
                                    arguments: catData.categories[i].id,
                                  );
                                },
                                child: Card(
                                  elevation: 3,
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 120,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              catData.categories[i].imageUrl,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0.0,
                                        left: 0.0,
                                        bottom: 0.0,
                                        child: Container(
                                          height: 20,
                                          width: 120,
                                          color: Colors.white.withOpacity(0.85),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.3),
                                            child: Center(
                                              child: Text(
                                                '${catData.categories[i].title}',
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          }
          return result;
        },
      ),
    );
  }
}

class DiscountsHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: Provider.of<ProductsProvider>(context, listen: false)
            .fetchDiscounts(context),
        builder: (context, snapShot) {
          Widget result;
          if (snapShot.connectionState == ConnectionState.waiting) {
            result = Text('');
          } else if (snapShot.hasError) {
            result = Text('');
          } else {
            result = Consumer<ProductsProvider>(
              builder: (context, dicountData, ch) => dicountData
                      .discounts.isEmpty
                  ? Text('')
                  : Column(
                      children: [
                        TitleWidget(
                          title: 'عروض و خصومات',
                          chipText: 'حصرياً',
                        ),
                        Container(
                          height: 250,
                          child: Center(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: dicountData.discounts.length,
                              itemBuilder: (context, i) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    ProductDetailsNew.routeName,
                                    arguments: dicountData.discounts[i].id,
                                  );
                                },
                                child: Card(
                                  elevation: 3,
                                  child: Container(
                                    height: 245,
                                    width: 140,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 150,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                dicountData
                                                    .discounts[i].imageUrl!,
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 90,
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  dicountData
                                                      .discounts[i].name!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '${dicountData.discounts[i].price.toString()}  جـ.م',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: TextStyle(
                                                    color: Colors.teal,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      '×',
                                                      style: TextStyle(
                                                        color: red,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${dicountData.discounts[i].oldPrice.toString()}  جـ.م',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            );
          }
          return result;
        },
      ),
    );
  }
}

class NewArrivals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<ProductsProvider>(context, listen: false).fetchProducts(),
      builder: (context, snapShot) {
        Widget result;
        if (snapShot.connectionState == ConnectionState.waiting) {
          result = SliverToBoxAdapter(child: Text(''));
        } else if (snapShot.hasError) {
          result = SliverToBoxAdapter(child: Text(''));
        } else {
          result = Consumer<ProductsProvider>(
            builder: (context, prodData, ch) => prodData.items.isEmpty
                ? SliverToBoxAdapter(child: Text(''))
                : SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        child: Card(
                          elevation: 3,
                          child: ProductItem(
                            imageUrl: prodData.items[i].imageUrl,
                            productName: prodData.items[i].name,
                            productPrice: prodData.items[i].price,
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                ProductDetailsNew.routeName,
                                arguments: prodData.items[i].id,
                              );
                            },
                          ),
                        ),
                      ),
                      childCount: prodData.items.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                    ),
                  ),
          );
        }
        return result;
      },
    );
  }
}
