import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/category_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/cat_products_screen.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class CategoriesScreen extends StatelessWidget {
  static const routeName = 'cat_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'الأقسام',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: FutureBuilder(
          future:
              Provider.of<CategoryProvider>(context, listen: false).fetchCats(),
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
                builder: (context, categoryData, child) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    itemCount: categoryData.categories.length,
                    itemBuilder: (context, i) => Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                CatProductsScreen.routeName,
                                arguments: categoryData.categories[i].id);
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey[100],
                            backgroundImage: NetworkImage(
                              categoryData.categories[i].imageUrl,
                            ),
                          ),
                          title: Text(
                            categoryData.categories[i].title!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
