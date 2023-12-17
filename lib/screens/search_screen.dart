import 'package:flutter/material.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'search_screen';
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('البحث في المنتجات'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            vertical: height * 0.001,
            horizontal: width * 0.05,
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                  child: CustomFormField(
                    labelText: 'البحث',
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [],
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
