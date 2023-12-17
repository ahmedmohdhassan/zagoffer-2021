import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/classes/user.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/edit_profile.dart';
import 'package:zagoffer/screens/favorites_screen.dart';
import 'package:zagoffer/screens/home_screen.dart';
import 'package:zagoffer/screens/orders_screen.dart';
import 'package:zagoffer/widgets/account_card.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class MyAccount extends StatefulWidget {
  static const routeName = 'my_account';

  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  String? userId;
  String? userToken;
  bool? isLoading;
  void getUserCreds() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      userId = _pref.getString('user_id');
      userToken = _pref.getString('userToken');
    });
  }

  void signOut() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setString('user_id', 'null');
    _pref.setString('userToken', 'null');
    Navigator.of(context)
        .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
  }

  @override
  void initState() {
    isLoading = true;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isLoading!) {
      getUserCreds();
    }
    setState(() {
      isLoading = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'حسابي',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.edit_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProfile.routeName,
                );
              },
            )
          ],
        ),
        body: isLoading == true
            ? Loading()
            : FutureBuilder(
                future: Provider.of<UserProvider>(context, listen: false)
                    .viewUserProfile(context, userId, userToken),
                builder: (context, snapShot) {
                  Widget result;
                  if (snapShot.hasError) {
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
                  } else if (snapShot.connectionState ==
                      ConnectionState.waiting) {
                    result = Loading();
                  } else {
                    result = Consumer<UserProvider>(
                      builder: (context, userData, ch) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  AccountCard(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    height: height * 0.12,
                                    width: width * 0.40,
                                    title: 'عدد النقاط',
                                    text: '0',
                                  ),
                                  AccountCard(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    height: height * 0.12,
                                    width: width * 0.40,
                                    title: 'الرصيد المتبقي',
                                    text: '0',
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: AccountCard(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                height: height * 0.12,
                                width: width,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                title:
                                    '${userData.user!.firstName} ${userData.user!.lastName}',
                                text: '${userData.user!.eMail}',
                                text2: '${userData.user!.mobileNo}',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF9F9F9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(OrdersScreen.routeName);
                                  },
                                  leading: Text(
                                    'طلباتي',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF9F9F9),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(FavoritesScreen.routeName);
                                  },
                                  leading: Text(
                                    'المفضلات',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.arrow_forward_ios),
                                    onPressed: () {},
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: height * 0.020,
                                horizontal: width * 0.10,
                              ),
                              child: GestureDetector(
                                onTap: () {
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
                          ],
                        ),
                      ),
                    );
                  }
                  return result;
                }),
      ),
    );
  }
}
