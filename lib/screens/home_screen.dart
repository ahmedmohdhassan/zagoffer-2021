import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_pro_nullsafety/carousel_pro_nullsafety.dart';
import 'package:zagoffer/classes/advertisement.dart';
import 'package:zagoffer/classes/cart.dart';
import 'package:zagoffer/classes/category_provider.dart';
import 'package:zagoffer/classes/companies.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/cart_screen.dart';
import 'package:zagoffer/screens/cat_products_screen.dart';
import 'package:zagoffer/screens/flashSale_screen.dart';
import 'package:zagoffer/screens/product_details_screen.dart';
import 'package:zagoffer/screens/search_screen.dart';
import 'package:zagoffer/widgets/category_item.dart';
import 'package:zagoffer/widgets/flash_sale.dart';
import 'package:zagoffer/widgets/flashsalebar.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';
import 'package:zagoffer/widgets/offers_widget.dart';
import 'package:zagoffer/widgets/product_item.dart';
import 'package:zagoffer/widgets/badge.dart';
import 'package:zagoffer/widgets/title_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'home_page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future refresh() async {
    setState(() {
      isLoading = true;
    });
    dynamic d = await Provider.of<ProductsProvider>(context, listen: false)
        .fetchProducts()
        .then((_) {
      setState(() {
        isLoading = false;
      });
    });
    return d;
  }

  bool flashSaleVisible = true;
  bool isInit = true;
  late bool isLoading;
  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      Provider.of<AdProvider>(context, listen: false)
          .fetchAds(context)
          .catchError((e) {
        print('$e');
      });
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchProducts()
          .catchError((e) {
        print(e);
      });
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchDiscounts(context)
          .catchError((e) {
        print(e);
      });
      Provider.of<ProductsProvider>(context, listen: false)
          .fetchFlashSale(context)
          .catchError((e) {
        print(e);
      });
      Provider.of<CategoryProvider>(context, listen: false)
          .fetchCats()
          .catchError((e) {
        print(e);
      });
      Provider.of<CompaniesProvider>(context, listen: false)
          .fetchComps()
          .catchError((e) {
        print(e);
      }).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var prodData = Provider.of<ProductsProvider>(context);
    var catData = Provider.of<CategoryProvider>(context);
    var adData = Provider.of<AdProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
            title: Text(
              'Zag Offer',
              style: TextStyle(
                color: Color(0xff2f2f2f),
                fontWeight: FontWeight.bold,
              ),
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
                        color: red,
                        child: ch,
                      ),
                child: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
              ),
            ],
          ),
          drawer: MyDrawer(),
          body: isLoading
              ? Loading()
              : RefreshIndicator(
                  displacement: 100,
                  backgroundColor: Colors.white,
                  color: red,
                  onRefresh: refresh,
                  child: Stack(
                    children: [
                      CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildListDelegate([
                              SizedBox(
                                height: 15,
                              ),
                              adData.sliderList.length == 0
                                  ? Text('')
                                  : Container(
                                      height: 120,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
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
                              catData.categories.isEmpty
                                  ? Text('')
                                  : Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      height: 114,
                                      child: Center(
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: catData.categories.length,
                                          itemBuilder: (context, i) => Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 2, vertical: 5),
                                            child: CategoryItem(
                                              imageUrl: catData
                                                  .categories[i].imageUrl,
                                              text: catData.categories[i].title,
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                  CatProductsScreen.routeName,
                                                  arguments:
                                                      catData.categories[i].id,
                                                );
                                              },
                                              height: 120,
                                              width: 120,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              prodData.flashSale.length == 0
                                  ? Text('')
                                  : FlashSaleBar(),
                              prodData.discounts.isEmpty
                                  ? Text('')
                                  : TitleWidget(
                                      title: 'عروض حصرية',
                                      chipText: 'حصرياً',
                                    ),
                              prodData.discounts.isEmpty
                                  ? Text('')
                                  : Container(
                                      height: 200,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: prodData.discounts.length,
                                        itemBuilder: (context, i) =>
                                            OffersWidget(
                                          imageUrl:
                                              prodData.discounts[i].imageUrl,
                                          productName:
                                              prodData.discounts[i].name,
                                          productPrice:
                                              '${prodData.discounts[i].price}',
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                              ProductDetails.routeName,
                                              arguments:
                                                  prodData.discounts[i].id,
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                              prodData.items.isEmpty
                                  ? Text('')
                                  : TitleWidget(
                                      title: 'وصل حديثاً',
                                      chipText: 'جديد',
                                    ),
                            ]),
                          ),
                          prodData.items.isEmpty
                              ? SliverToBoxAdapter(
                                  child: Text(''),
                                )
                              : SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, i) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 5),
                                      child: ProductItem(
                                        imageUrl: prodData.items[i].imageUrl,
                                        productName: prodData.items[i].name,
                                        productPrice: prodData.items[i].price,
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                            ProductDetails.routeName,
                                            arguments: prodData.items[i].id,
                                          );
                                        },
                                      ),
                                    ),
                                    childCount: prodData.items.length,
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1,
                                    mainAxisSpacing: 10,
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                  ),
                                )
                        ],
                      ),
                      prodData.flashSale.isEmpty
                          ? Center()
                          : Positioned(
                              top: height * 0.25,
                              right: width * 0.10,
                              child: Visibility(
                                visible: flashSaleVisible,
                                child: FlashSalePopUp(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(FlashSaleScreen.routeName);
                                  },
                                  onClosed: () {
                                    setState(() {
                                      flashSaleVisible = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

// SizedBox(
//                             height: 15,
//                           ),
//                           adData.sliderList.length == 0
//                               ? SliverToBoxAdapter(child: Center())
//                               : CarouselSlider(
//                                   options: CarouselOptions(
//                                     height: 120,
//                                     enlargeCenterPage: true,
//                                     scrollDirection: Axis.horizontal,
//                                     autoPlay: true,
//                                     autoPlayInterval:
//                                         const Duration(seconds: 4),
//                                     autoPlayCurve: Curves.fastOutSlowIn,
//                                   ),
//                                   items: adData.sliderList,
//                                 ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10,
//                             ),
//                             height: 114,
//                             child: Center(
//                               child: catData.categories.isEmpty
//                                   ? SliverToBoxAdapter(child: Center())
//                                   : ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: catData.categories.length,
//                                       itemBuilder: (context, i) => Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 2, vertical: 5),
//                                         child: CategoryItem(
//                                           imageUrl:
//                                               catData.categories[i].imageUrl,
//                                           text: catData.categories[i].title,
//                                           onPressed: () {
//                                             Navigator.of(context).pushNamed(
//                                               CatProductsScreen.routeName,
//                                               arguments:
//                                                   catData.categories[i].id,
//                                             );
//                                           },
//                                           height: 120,
//                                           width: 120,
//                                         ),
//                                       ),
//                                     ),
//                             ),
//                           ),
//                           prodData.flashSale.length == 0
//                               ? SliverToBoxAdapter(child: Center())
//                               : FlashSaleBar(),
//                           prodData.discounts.isEmpty
//                               ? SliverToBoxAdapter(child: Center())
//                               : Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10, vertical: 10),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Chip(
//                                         elevation: 1,
//                                         backgroundColor: Colors.orangeAccent,
//                                         label: Container(
//                                           color: Colors.transparent,
//                                           width: 45,
//                                           child: Center(
//                                             child: FadeAnimatedTextKit(
//                                               repeatForever: true,
//                                               text: ['حصرياً'],
//                                               textStyle: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(
//                                         'العروض الحصرية',
//                                         style: TextStyle(
//                                           color: Theme.of(context).accentColor,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                           prodData.discounts.isEmpty
//                               ? SliverToBoxAdapter(child: Center())
//                               : Container(
//                                   height: 200,
//                                   child: ListView.builder(
//                                     scrollDirection: Axis.horizontal,
//                                     itemCount: prodData.discounts.length,
//                                     itemBuilder: (context, i) => OffersWidget(
//                                       imageUrl: prodData.discounts[i].imageUrl,
//                                       productName: prodData.discounts[i].name,
//                                       productPrice:
//                                           '${prodData.discounts[i].price}',
//                                       onPressed: () {
//                                         Navigator.of(context).pushNamed(
//                                           ProductDetails.routeName,
//                                           arguments: prodData.discounts[i].id,
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 10),
//                             child: prodData.items.isEmpty
//                                 ? SliverToBoxAdapter(child: Center())
//                                 : Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Chip(
//                                         elevation: 1,
//                                         backgroundColor: Colors.orangeAccent,
//                                         label: Container(
//                                           color: Colors.transparent,
//                                           width: 40,
//                                           child: Center(
//                                             child: FadeAnimatedTextKit(
//                                               repeatForever: true,
//                                               text: ['جديد'],
//                                               textStyle: TextStyle(
//                                                 color: Colors.white,
//                                                 fontWeight: FontWeight.bold,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text(
//                                         'وصل حديثاً',
//                                         style: TextStyle(
//                                           color: Theme.of(context).accentColor,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                     ],
//                                   ),
//                           ),




// CarouselSlider(
//                                       options: CarouselOptions(
//                                         height: 120,
//                                         enlargeCenterPage: true,
//                                         scrollDirection: Axis.horizontal,
//                                         autoPlay: true,
//                                         autoPlayInterval:
//                                             const Duration(seconds: 4),
//                                         autoPlayCurve: Curves.fastOutSlowIn,
//                                       ),
//                                       items: adData.sliderList,
//                                     )