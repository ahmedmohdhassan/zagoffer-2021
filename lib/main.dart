import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/Address_provider.dart';
import 'package:zagoffer/classes/advertisement.dart';
import 'package:zagoffer/classes/cart.dart';
import 'package:zagoffer/classes/category_provider.dart';
import 'package:zagoffer/classes/companies.dart';
import 'package:zagoffer/classes/orders_class.dart';
import 'package:zagoffer/classes/products_provider.dart';
import 'package:zagoffer/classes/user.dart';
import 'package:zagoffer/notifications/local_notif_service.dart';
import 'package:zagoffer/notifications/push_nofitications.dart';
import 'package:zagoffer/screens/add_address.dart';
import 'package:zagoffer/screens/cart_screen.dart';
import 'package:zagoffer/screens/cat_products_screen.dart';
import 'package:zagoffer/screens/categories_screen.dart';
import 'package:zagoffer/screens/contact_us_screen.dart';
import 'package:zagoffer/screens/edit_profile.dart';
import 'package:zagoffer/screens/favorites_screen.dart';
import 'package:zagoffer/screens/flashSale_screen.dart';
import 'package:zagoffer/screens/home2.dart';
import 'package:zagoffer/screens/home_screen.dart';
import 'package:zagoffer/screens/login_screen.dart';
import 'package:zagoffer/screens/man_products_screen.dart';
import 'package:zagoffer/screens/manufacturers.dart';
import 'package:zagoffer/screens/my_account_screen.dart';
import 'package:zagoffer/screens/orders_screen.dart';
import 'package:zagoffer/screens/password_recovery.dart';
import 'package:zagoffer/screens/privacy.dart';
import 'package:zagoffer/screens/prod_details_new.dart';
import 'package:zagoffer/screens/product_details_screen.dart';
import 'package:zagoffer/screens/return_product_screen.dart';
import 'package:zagoffer/screens/search_screen.dart';
import 'package:zagoffer/screens/signup_screen.dart';
import 'package:zagoffer/screens/start_screen.dart';
import 'package:zagoffer/screens/view_ur_Products.dart';
import 'package:uni_links/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  pushNotification.init();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

final PushNotificationManager pushNotification = PushNotificationManager();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
ThemeData theme = ThemeData();

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription? _linkSubscription;

  Future<void> initPlatformState() async {
    _linkSubscription = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      setState(() {
        parseRoute(uri!, context);
      });
    }, onError: (Object err) {
      print('Got error $err');
    });
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  void dispose() {
    _linkSubscription!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    LocalNotificationService.initialize(context);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CategoryProvider(),
        ),
        ChangeNotifierProvider.value(
          value: CompaniesProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
        ChangeNotifierProvider.value(
          value: AdProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
        ChangeNotifierProvider.value(
          value: AddressProvider(),
        ),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Zag Offer',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[200],
          fontFamily: 'Tajawal',
          appBarTheme: AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.grey,
                size: 30,
              ),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
                fontSize: 16,
              ),
              actionsIconTheme: IconThemeData(
                color: Colors.grey,
                size: 30,
              )),
          iconTheme: IconThemeData(
            color: Colors.grey,
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: Color(0xff2f2f2f)),
        ),
        home: HomeScreen(),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          StartScreen.routeName: (context) => StartScreen(),
          ProductDetails.routeName: (context) => ProductDetails(),
          FlashSaleScreen.routeName: (context) => FlashSaleScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          LogInScreen.routeName: (context) => LogInScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          PassWordRecoveryScreen.routeName: (context) =>
              PassWordRecoveryScreen(),
          ViewUrProducts.routeName: (context) => ViewUrProducts(),
          ContactUs.routeName: (context) => ContactUs(),
          AddAddress.routeName: (context) => AddAddress(),
          ReturnProduct.routeName: (context) => ReturnProduct(),
          MyAccount.routeName: (context) => MyAccount(),
          EditProfile.routeName: (context) => EditProfile(),
          FavoritesScreen.routeName: (context) => FavoritesScreen(),
          CategoriesScreen.routeName: (context) => CategoriesScreen(),
          ManufactCompanies.routeName: (context) => ManufactCompanies(),
          PrivacyScreen.routeName: (context) => PrivacyScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          CatProductsScreen.routeName: (context) => CatProductsScreen(),
          CompProductsScreen.routeName: (context) => CompProductsScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          ProductDetailsNew.routeName: (context) => ProductDetailsNew(),
        },
      ),
    );
  }
}

void parseRoute(Uri uri, BuildContext context) {
  if (uri.queryParameters.isEmpty) {
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  } else if (uri.queryParameters.isNotEmpty) {
    print(uri.queryParameters);
    Map<String, String> parameters = uri.queryParameters;
    String extractedId = parameters['product_id']!;
    print(extractedId);
    navigatorKey.currentState!.pushNamed(HomeScreen.routeName).then((_) =>
        Future.delayed(Duration(seconds: 1)).then((_) => navigatorKey
            .currentState!
            .pushNamed(ProductDetails.routeName, arguments: extractedId)));
    print('excuted.....................................');
  } else {
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  }
}




//https://zagoffer.com/s/index.php?route=product/product&product_id=32

// ThemeData(
//           primarySwatch: Colors.grey,
//           scaffoldBackgroundColor: Colors.grey[200],
//           fontFamily: 'Tajawal',
//           accentColor: Color(0xff2f2f2f),
//           appBarTheme: AppBarTheme(
//             color: Colors.white,
//             brightness: Brightness.dark,
//             iconTheme: IconThemeData(
//               color: Color(0xff2f2f2f),
//             ),
//           ),
//         ),