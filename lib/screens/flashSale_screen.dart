import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/product_details_screen.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class FlashSaleScreen extends StatelessWidget {
  static const routeName = 'flash_sale';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'العروض الفورية',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<ProductsProvider>(context, listen: false)
              .fetchFlashSale(context),
          builder: (context, snapShot) {
            Widget result;
            if (snapShot.connectionState == ConnectionState.waiting) {
              result = Loading();
            } else if (snapShot.hasError) {
              result = Container(
                child: Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.signal_wifi_off,
                          color: red.withOpacity(0.5),
                          size: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          ' خطأ في الإتصال بالإنترنت .....  ',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: red,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              result = Consumer<ProductsProvider>(
                builder: (context, flashSale, widget) =>
                    flashSale.flashSale.length == 0
                        ? Center(
                            child: Text('لا يوجد منتجات للعرض'),
                          )
                        : Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView.builder(
                              itemCount: flashSale.flashSale.length,
                              itemBuilder: (context, i) => GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    ProductDetails.routeName,
                                    arguments: flashSale.flashSale[i].id,
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  child: Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    elevation: 3,
                                    child: ListTile(
                                      leading: Image.network(
                                          flashSale.flashSale[i].imageUrl!),
                                      title: Text(
                                        '${flashSale.flashSale[i].name}',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                '${flashSale.flashSale[i].price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' بدلاً من ',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${flashSale.flashSale[i].oldPrice!.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                        ]),
                                      ),
                                      trailing: Column(
                                        children: [
                                          AnimatedTextKit(
                                            repeatForever: true,
                                            animatedTexts: [
                                              FadeAnimatedText(
                                                'ينتهي العرض في:',
                                                textStyle: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          AnimatedTextKit(
                                            repeatForever: true,
                                            animatedTexts: [
                                              FadeAnimatedText(
                                                '${flashSale.flashSale[i].discountEnd}',
                                                textStyle: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
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
    );
  }
}


// Container(
//                                 height: 150,
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 7, horizontal: 10),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: const BorderRadius.all(
//                                     Radius.circular(25),
//                                   ),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     Expanded(
//                                       child: Image.network(
//                                         flashSale.flashSale[i].imageUrl,
//                                         height: 100,
//                                         width: 100,
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10),
//                                       child: Expanded(
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               '${flashSale.flashSale[i].name}',
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             RichText(
//                                               overflow: TextOverflow.ellipsis,
//                                               text: TextSpan(children: [
//                                                 TextSpan(
//                                                   text:
//                                                       '${flashSale.flashSale[i].price.toStringAsFixed(2)}',
//                                                   style: TextStyle(
//                                                     color: Colors.green,
//                                                   ),
//                                                 ),
//                                                 TextSpan(
//                                                   text: ' بدلاً من ',
//                                                   style: TextStyle(
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                                 TextSpan(
//                                                   text:
//                                                       '${flashSale.flashSale[i].oldPrice.toStringAsFixed(2)}',
//                                                   style: TextStyle(
//                                                     color: Colors.red,
//                                                     decoration: TextDecoration
//                                                         .lineThrough,
//                                                   ),
//                                                 ),
//                                               ]),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           FadeAnimatedTextKit(
//                                             repeatForever: true,
//                                             text: [
//                                               'ينتهي العرض في:',
//                                             ],
//                                             textStyle: TextStyle(
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           FadeAnimatedTextKit(
//                                             repeatForever: true,
//                                             text: [
//                                               '${flashSale.flashSale[i].discountEnd}',
//                                             ],
//                                             textStyle: TextStyle(
//                                               color: Colors.red,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               ),