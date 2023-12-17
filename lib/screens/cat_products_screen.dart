import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/category_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/product_details_screen.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';

class CatProductsScreen extends StatelessWidget {
  static const routeName = 'cat_products_screen';
  @override
  Widget build(BuildContext context) {
    final catId = ModalRoute.of(context)!.settings.arguments;
    final category = Provider.of<CategoryProvider>(context, listen: false)
        .categories
        .firstWhere((cat) => cat.id == catId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '${category.title}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<CategoryProvider>(context, listen: false)
              .fetchCatProducts(catId as String?),
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
              result = Consumer<CategoryProvider>(
                builder: (context, catData, widget) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: catData.catProducts.length,
                    itemBuilder: (context, i) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            ProductDetails.routeName,
                            arguments: catData.catProducts[i].id);
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(25),
                        ),
                        child: GridTile(
                          child: Image.network(catData.catProducts[i].imageUrl!),
                          footer: GridTileBar(
                            backgroundColor: Colors.black54,
                            title: Text(
                              catData.catProducts[i].name!,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(
                              '${catData.catProducts[i].price.toStringAsFixed(2)} ج.م',
                              style: TextStyle(color: Colors.white),
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
