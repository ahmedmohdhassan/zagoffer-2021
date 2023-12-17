import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/categories_screen.dart';
import 'package:zagoffer/screens/contact_us_screen.dart';
import 'package:zagoffer/screens/home2.dart';
import 'package:zagoffer/screens/home_screen.dart';
import 'package:zagoffer/screens/login_screen.dart';
import 'package:zagoffer/screens/manufacturers.dart';
import 'package:zagoffer/screens/my_account_screen.dart';
import 'package:zagoffer/screens/privacy.dart';
import 'package:zagoffer/screens/return_product_screen.dart';
import 'package:zagoffer/screens/view_ur_Products.dart';
import 'package:zagoffer/widgets/drawer_item.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  String? userId;
  String? userToken;
  bool? signInVisible;
  bool? signOutVisible;

  void getUserCredentials() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      userId = _pref.getString('user_id');
      userToken = _pref.getString('userToken');
    });
  }

  @override
  void initState() {
    getUserCredentials();
    super.initState();
  }

  void signOut() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('user_id', 'null');
    _pref.setString('userToken', 'null');
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('images/logo.png'),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: ListView(
              children: [
                DrawerItem(
                  text: 'الرئيسية',
                  icon: Icons.home_outlined,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        HomeScreen.routeName, (route) => false);
                  },
                ),
                userId == 'null' || userToken == 'null'
                    ? Center()
                    : DrawerItem(
                        text: 'حسابي الشخصي',
                        icon: Icons.person_outline,
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed(MyAccount.routeName);
                        },
                      ),
                DrawerItem(
                  text: 'الأقسام',
                  icon: Icons.menu_open,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(CategoriesScreen.routeName);
                  },
                ),
                DrawerItem(
                  text: 'الشركات و المصانع',
                  icon: Icons.precision_manufacturing_outlined,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context)
                        .pushNamed(ManufactCompanies.routeName);
                  },
                ),
                DrawerItem(
                  text: 'الاستخدام والخصوصية',
                  icon: Icons.privacy_tip_outlined,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(PrivacyScreen.routeName);
                  },
                ),
                DrawerItem(
                  text: 'ارجاع المنتج',
                  icon: Icons.sync,
                  iconColor: Colors.lightGreen,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(ReturnProduct.routeName);
                  },
                ),
                DrawerItem(
                  text: 'تواصل معنا',
                  icon: Icons.call,
                  iconColor: Colors.teal,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(ContactUs.routeName);
                  },
                ),
                DrawerItem(
                  text: 'شارك منتجاتك',
                  icon: Icons.mobile_screen_share,
                  iconColor: red,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed(ViewUrProducts.routeName);
                  },
                ),
              ],
            ),
          ),
          Visibility(
            visible: userId != 'null' || userToken != 'null'
                ? signInVisible = false
                : signInVisible = true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed(LogInScreen.routeName);
                },
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'تسجيل دخول',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: userId != 'null' || userToken != 'null'
                ? signOutVisible = true
                : signOutVisible = false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  signOut();
                },
                child: Container(
                  height: 75,
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'تسجيل خروج',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
}
