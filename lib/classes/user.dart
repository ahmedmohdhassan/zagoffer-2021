import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zagoffer/classes/api_handler.dart';

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.eMail,
    required this.mobileNo,
    required this.token,
  });
  String? id;
  String? firstName;
  String? lastName;
  String? eMail;
  String? mobileNo;
  String? token;
}

class UserProvider with ChangeNotifier {
  User? _user;
  User? get user {
    return _user;
  }

  Future viewUserProfile(
      BuildContext context, String? userId, String? userToken) async {
    final String url = 'https://zagoffer.com/cartapi/edit_profile.php';
    var body = {
      'id': '$userId',
      'token': '$userToken',
      'type': '1',
    };
    try {
      var response = await http.post(Uri.parse(url), body: body);
      print(response.body);
      var jsonData = jsonDecode(response.body);
      if (jsonData == 0) {
        errorBar(context);
      } else {
        _user = User(
          id: jsonData[0]['customer_id'],
          firstName: jsonData[0]['firstname'],
          lastName: jsonData[0]['lastname'],
          eMail: jsonData[0]['email'],
          mobileNo: jsonData[0]['telephone'],
          token: jsonData[0]['code'],
        );
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }

  Future editUserProfile(
    BuildContext context,
    String? userId,
    String? userToken,
    String? firstName,
    String? lastName,
    String? phoneNo,
    String? oldPassword,
    String? newPassword,
  ) async {
    final String url = 'https://zagoffer.com/cartapi/edit_profile.php';
    var body1 = {
      'id': '$userId',
      'token': '$userToken',
      'type': '2',
      'firstname': '$firstName',
      'lastname': '$lastName',
      'telephone': '$phoneNo',
      'password_old': '$oldPassword',
      'password_new': '$newPassword',
    };

    var body2 = {
      'id': '$userId',
      'token': '$userToken',
      'type': '2',
      'firstname': '$firstName',
      'lastname': '$lastName',
      'telephone': '$phoneNo',
    };

    try {
      var response = await http.post(
        Uri.parse(url),
        body: oldPassword != null && newPassword != null ? body1 : body2,
      );
      print(response.body);
      var jsonData = jsonDecode(response.body);
      if (jsonData == 0) {
        errorBar(context);
      } else {
        print(jsonData);
        print('تم الحفظ');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'تم الحفظ بنجاح...',
            textDirection: TextDirection.rtl,
          ),
          duration: Duration(seconds: 2),
        ));
        notifyListeners();
      }
    } catch (e) {
      print(e);
      throw (e);
    }
  }
}
