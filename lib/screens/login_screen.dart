import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/classes/api_handler.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/password_recovery.dart';
import 'package:zagoffer/screens/signup_screen.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class LogInScreen extends StatefulWidget {
  static const routeName = 'login_screen';
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _form = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final passWordNode = FocusNode();
  String? username;
  String? passWord;
  String? fireBaseToken;
  bool? isVisible;
  bool? isLoading;

  void saveForm() {
    _form.currentState!.validate();
    bool valid = _form.currentState!.validate();
    if (valid) {
      setState(() {
        isLoading = true;
      });
      _form.currentState!.save();
      ApiHandler _api = ApiHandler();
      _api.logIn(context, username, passWord, fireBaseToken).catchError((e) {
        print(e);
      }).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void getFireBaseToken() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      fireBaseToken = _pref.getString('firebase_token');
    });
    print(fireBaseToken);
  }

  @override
  void dispose() {
    nameNode.dispose();
    passWordNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getFireBaseToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _form,
            child: isLoading == true
                ? Loading()
                : ListView(
                    children: [
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Image.asset(
                        'images/logo.png',
                        height: height * .25,
                        width: width * 0.25,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: width * 0.10,
                        ),
                        child: CustomFormField(
                          labelText: 'البريد الالكتروني',
                          focusNode: nameNode,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          onChanged: (String? value) {
                            setState(() {
                              username = value;
                            });
                          },
                          onSubmitted: (String? value) {
                            username = value;
                            FocusScope.of(context).requestFocus(passWordNode);
                          },
                          onSaved: (String? value) {
                            username = value;
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل إسم المستخدم ...';
                            } else if (!value.contains('@') ||
                                !value.contains('.')) {
                              return 'من فضلك ادخل بريد الكتروني صحيح';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: width * 0.10,
                        ),
                        child: CustomFormField(
                          obscure: isVisible == true ? false : true,
                          labelText: 'كلمة المرور',
                          focusNode: passWordNode,
                          maxLines: 1,
                          textInputAction: TextInputAction.done,
                          suffixIconButton: IconButton(
                            icon: Icon(
                              isVisible == true
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                isVisible == true
                                    ? isVisible = false
                                    : isVisible = true;
                              });
                            },
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              passWord = value;
                            });
                          },
                          onSubmitted: (String? value) {
                            passWord = value;
                          },
                          onSaved: (String? value) {
                            passWord = value;
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل كلمة المرور ...';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          saveForm();
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: width * 0.25,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: red,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
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
                      Divider(
                        color: Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(0.5),
                        indent: width * 0.15,
                        endIndent: width * 0.15,
                        thickness: 0.5,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: width * 0.10,
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'ليس لديك حساب؟',
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: 16,
                                  ),
                                ),
                                TextSpan(text: '  '),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context)
                                        .pushNamed(SignUpScreen.routeName),
                                  text: 'انشيء حسابك الآن',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 7,
                          horizontal: width * 0.10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(
                            //   Icons.vpn_key_sharp,
                            //   color: Colors.grey[500],
                            //   size: 25,
                            // ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'نسيت كلمة المرور؟',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(text: '  '),
                                  TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.of(context)
                                          .pushNamed(
                                              PassWordRecoveryScreen.routeName),
                                    text: 'اعادة ضبط كلمة المرور',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
