import 'package:flutter/material.dart';
import 'package:zagoffer/classes/api_handler.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = 'sign_up_screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNo;
  String? address;
  String? passWord1;
  String? passWord2;
  bool? newsLetter = false;
  bool isSent = false;
  bool buttonVisible = true;
  bool isLoading = false;

  ApiHandler _api = ApiHandler();

  final _form = GlobalKey<FormState>();

  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final emailNode = FocusNode();
  final phoneNode = FocusNode();
  final addressNode = FocusNode();
  final passWord1Node = FocusNode();
  final passWord2Node = FocusNode();
  final newsLetterNode = FocusNode();

  void saveForm() {
    _form.currentState!.validate();
    bool isValid = _form.currentState!.validate();
    if (isValid == true) {
      setState(() {
        buttonVisible = false;
        isLoading = true;
      });
      _form.currentState!.save();
      _api
          .register(context, firstName, lastName, phoneNo, passWord1, email,
              address, newsLetter)
          .catchError((e) {
        print(e);
      }).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  void dispose() {
    firstNameNode.dispose();
    lastNameNode.dispose();
    emailNode.dispose();
    phoneNode.dispose();
    addressNode.dispose();
    passWord1Node.dispose();
    passWord2Node.dispose();
    newsLetterNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'إنشاء حساب جديد',
            style: TextStyle(
              color: Color(0xff2f2f2f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _form,
            child: ListView(
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Center(
                  child: Text(
                    'من فضلك ادخل البيانات المطلوبة لإنشاء حسابك',
                    softWrap: true,
                    style: TextStyle(
                      color: red,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: width * 0.10,
                  ),
                  child: CustomFormField(
                    labelText: 'الإسم الأول',
                    focusNode: firstNameNode,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    onChanged: (String? value) {
                      setState(() {
                        firstName = value;
                      });
                    },
                    onSubmitted: (String? value) {
                      firstName = value;
                      FocusScope.of(context).requestFocus(lastNameNode);
                    },
                    onSaved: (String? value) {
                      firstName = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الإسم الأول';
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
                    labelText: 'الإسم الأخير',
                    focusNode: lastNameNode,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    onChanged: (String? value) {
                      setState(() {
                        lastName = value;
                      });
                    },
                    onSubmitted: (String? value) {
                      lastName = value;
                      FocusScope.of(context).requestFocus(emailNode);
                    },
                    onSaved: (String? value) {
                      lastName = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل الإسم الأخير';
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
                    labelText: 'البريد الإلكتروني',
                    focusNode: emailNode,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.emailAddress,
                    onChanged: (String? value) {
                      setState(() {
                        email = value;
                      });
                    },
                    onSubmitted: (String? value) {
                      email = value;
                      FocusScope.of(context).requestFocus(addressNode);
                    },
                    onSaved: (String? value) {
                      email = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل البريد الإلكتروني';
                      } else if (!value.contains('@') || !value.contains('.')) {
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
                    labelText: 'العنوان',
                    focusNode: addressNode,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    onChanged: (String? value) {
                      setState(() {
                        address = value;
                      });
                    },
                    onSubmitted: (String? value) {
                      address = value;
                      FocusScope.of(context).requestFocus(phoneNode);
                    },
                    onSaved: (String? value) {
                      address = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل العنوان الخاص بك';
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
                    labelText: 'رقم المحمول',
                    focusNode: phoneNode,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.phone,
                    onChanged: (String? value) {
                      setState(() {
                        phoneNo = value;
                      });
                    },
                    onSubmitted: (String? value) {
                      phoneNo = value;
                      FocusScope.of(context).requestFocus(passWord1Node);
                    },
                    onSaved: (String? value) {
                      phoneNo = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل رقم الموبايل الخاص بك';
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
                    labelText: 'كلمة المرور',
                    focusNode: passWord1Node,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    obscure: true,
                    onChanged: (String? value) {
                      setState(() {
                        passWord1 = value;
                      });
                    },
                    onSubmitted: (String? value) {
                      passWord1 = value;
                      FocusScope.of(context).requestFocus(passWord2Node);
                    },
                    onSaved: (String? value) {
                      passWord1 = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك ادخل كلمة المرور';
                      } else if (passWord1 != passWord2) {
                        return 'يجب ادخال نفس كلمة المرور';
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
                    labelText: 'تأكيد كلمة المرور',
                    focusNode: passWord2Node,
                    textInputAction: TextInputAction.next,
                    obscure: true,
                    maxLines: 1,
                    onChanged: (String? value) {
                      setState(() {
                        passWord2 = value;
                      });
                    },
                    onSubmitted: (String? value) {
                      passWord2 = value;
                      FocusScope.of(context).requestFocus(newsLetterNode);
                    },
                    onSaved: (String? value) {
                      passWord2 = value;
                    },
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return ' من فضلك ادخل كلمة المرور مرة أخرى للتأكيد';
                      } else if (passWord2 != passWord1) {
                        return 'يجب ادخال نفس كلمة المرور';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Divider(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  indent: width * 0.15,
                  endIndent: width * 0.15,
                  thickness: 0.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      focusNode: newsLetterNode,
                      value: newsLetter,
                      activeColor: white,
                      focusColor: Colors.blueAccent,
                      hoverColor: Colors.blueAccent,
                      checkColor: red,
                      onChanged: (bool? value) {
                        print(value);
                        setState(() {
                          newsLetter = value;
                        });
                      },
                    ),
                    Text(
                      'الاشتراك لمعرفة اخر العروض الحصرية و كل جديد',
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: buttonVisible,
                  child: GestureDetector(
                    onTap: () {
                      saveForm();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width * 0.25,
                        vertical: 20,
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
                          'إنشاء الحساب',
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
                isLoading == true ? Loading() : Center(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
