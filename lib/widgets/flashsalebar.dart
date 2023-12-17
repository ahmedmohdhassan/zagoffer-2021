import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/screens/flashSale_screen.dart';

class FlashSaleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<ProductsProvider>(context, listen: false)
        .fetchFlashSale(context);
    final flashSaleData = Provider.of<ProductsProvider>(context);
    return flashSaleData.flashSale.isEmpty
        ? Text('')
        : GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(FlashSaleScreen.routeName);
            },
            child: Container(
              height: 30,
              margin: const EdgeInsets.symmetric(
                vertical: 3,
                horizontal: 10,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.redAccent,
                    Colors.orangeAccent,
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        FadeAnimatedText(
                          'بادر قبل نفاذ الوقت',
                          textStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              'عروض فورية...',
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Tajawal',
                              ),
                              speed: Duration(milliseconds: 100),
                            ),
                          ],
                          pause: Duration(seconds: 2),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.flash_on,
                        color: Colors.amberAccent,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
