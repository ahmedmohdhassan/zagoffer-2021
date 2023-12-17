import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/screens/my_account_screen.dart';

ScaffoldFeatureController errorBar(BuildContext context) {
  ScaffoldFeatureController errorBar =
      ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        'خطأ في الإتصال . . .',
        textDirection: TextDirection.rtl,
      ),
    ),
  );
  return errorBar;
}

class ApiHandler {
  //////////////////
  ///This is for new sellers to share their products on ZagOffer:
  Future viewUrProducts(
    BuildContext context,
    String? fullName,
    String? mobileNo,
    String? activityName,
    String? activityAddress,
    String? currentcase,
    String? activityPhone,
  ) async {
    final url =
        'https://zagoffer.com/cartapi/new_saller.php/?name=$fullName&mobile=$mobileNo&store_name=$activityName&store_address=$activityAddress&store_case=$currentcase&store_phone=$activityPhone';

    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
      } else {
        errorBar(context);
      }
    } catch (e) {
      throw (e);
    }
  }

////////////////////////
  ///This is for new users :
  Future register(
    BuildContext context,
    String? firstName,
    String? lastName,
    String? mobileNo,
    String? passWord,
    String? email,
    String? address,
    bool? newsletter,
  ) async {
    final String url = 'https://zagoffer.com/cartapi/register.php';
    var body = {
      'fname': firstName,
      'lname': lastName,
      'mobile': mobileNo,
      'password': passWord,
      'email': email,
      'address': address,
      'newsletter': newsletter == true ? '1' : '0',
    };
    try {
      var response = await http.post(Uri.parse(url), body: body);
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        if (jsonData != 0) {
          print('تم انشاء الحساب بنجاح . . .');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'تم انشاء الحساب بنجاح . . .',
                textDirection: TextDirection.rtl,
              ),
              duration: Duration(seconds: 2),
            ),
          );
        } else {
          print('Error ////////////////////////////////////////////');
          errorBar(context);
        }
      } else {
        print('Connection Error ////////////////////////////////////////////');
        errorBar(context);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  ///////////////////////////////////////////////////////
  /// This is for Logging in :
  Future logIn(
    BuildContext context,
    String? email,
    String? passWord,
    String? fireBaseToken,
  ) async {
    final String url = 'https://zagoffer.com/cartapi/login.php';
    var body = {
      'email': '$email',
      'password': '$passWord',
      'firetoken': '$fireBaseToken',
    };
    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
      );
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      if (response.statusCode == 200) {
        if (jsonData['id'] != 0 || jsonData['api_key'] != 0) {
          String userId = jsonData['id'];
          String userToken = jsonData['api_key'];
          String userGroupId = jsonData['group_id'];
          SharedPreferences _pref = await SharedPreferences.getInstance();
          _pref.setString('userToken', userToken);
          _pref.setString('user_id', userId);
          _pref.setString('user_groupId', userGroupId);
          Navigator.of(context)
              .pushNamed(MyAccount.routeName, arguments: userId);
        } else {
          errorBar(context);
          print(
              'no user ///////////////////////////////////////////////////////');
        }
      } else {
        errorBar(context);
        print(
            'Error${response.statusCode}////////////////////////////////////// ');
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
////////////////////////////////////////////////////////////////////////////////
  /// This is to reset the user's password:

  Future resetPassord(BuildContext context, String? userEmail) async {
    final String url = 'https://zagoffer.com/cartapi/forget.php';
    var body = {
      'email': userEmail,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        body: body,
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        if (jsonData == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'من فضلك راجع البريد الالكتروني لإعادة ضبط كلمة المرور',
                softWrap: true,
                textDirection: TextDirection.rtl,
              ),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          errorBar(context);
        }
      } else {
        errorBar(context);
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
