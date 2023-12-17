import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/companies.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/product_details_screen.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';

class CompProductsScreen extends StatelessWidget {
  static const routeName = 'comp_products_screen';
  @override
  Widget build(BuildContext context) {
    final compId = ModalRoute.of(context)!.settings.arguments as String?;
    final Company company =
        Provider.of<CompaniesProvider>(context, listen: false)
            .companies
            .firstWhere((comp) => comp.id == compId);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            company.name!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<CompaniesProvider>(context, listen: false)
              .fetchCompProducts(compId),
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
              result = Consumer<CompaniesProvider>(
                builder: (context, compData, widget) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: compData.compProducts.isEmpty
                      ? Center(
                          child: Text('لا يوجد منتجات للعرض'),
                        )
                      : GridView.builder(
                          itemCount: compData.compProducts.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                          ),
                          itemBuilder: (context, i) => ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  ProductDetails.routeName,
                                  arguments: compData.compProducts[i].id,
                                );
                              },
                              child: GridTile(
                                child: Image.network(
                                    compData.compProducts[i].imageUrl!),
                                footer: GridTileBar(
                                  backgroundColor: Colors.black54,
                                  title: Text(compData.compProducts[i].name!),
                                  trailing: Text(
                                    '${compData.compProducts[i].price} ج.م',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
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
