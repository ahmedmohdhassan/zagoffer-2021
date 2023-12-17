import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/companies.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/man_products_screen.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class ManufactCompanies extends StatelessWidget {
  static const routeName = 'man_comp';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'الشركات والمصانع',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
          future: Provider.of<CompaniesProvider>(context, listen: false)
              .fetchComps(),
          builder: (context, snapShot) {
            Widget result;
            if (snapShot.connectionState == ConnectionState.waiting) {
              result = Loading();
            } else if (snapShot.hasError) {
              print(snapShot.error);
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
                builder: (context, companiesData, child) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    itemCount: companiesData.companies.length,
                    itemBuilder: (context, i) => Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              CompProductsScreen.routeName,
                              arguments: companiesData.companies[i].id,
                            );
                          },
                          leading: Image.network(
                            companiesData.companies[i].imageUrl!,
                            height: 100,
                            width: 70,
                          ),
                          title: Text(
                            companiesData.companies[i].name!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(0.5),
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
