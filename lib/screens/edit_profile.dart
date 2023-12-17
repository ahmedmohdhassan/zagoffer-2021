import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zagoffer/classes/user.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';

class EditProfile extends StatefulWidget {
  static const routeName = 'edit_profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? firstName;
  String? lastName;
  String? phoneNo;
  String? userId;
  String? userToken;
  String? oldPassword;
  String? password1;
  String? password2;
  bool? isLoading;
  bool changePassword = false;
  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final phoneNode = FocusNode();
  final oldPassNode = FocusNode();
  final pass1Node = FocusNode();
  final pass2Node = FocusNode();
  final _form = GlobalKey<FormState>();

  void getUserCreds() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      userId = _pref.getString('user_id');
      userToken = _pref.getString('userToken');
    });
  }

  void saveForm() {
    _form.currentState!.validate();
    bool valid = _form.currentState!.validate();
    if (valid) {
      _form.currentState!.save();
      setState(() {
        isLoading = true;
      });
      Provider.of<UserProvider>(context, listen: false)
          .editUserProfile(context, userId, userToken, firstName, lastName,
              phoneNo, oldPassword, password1)
          .then((_) {
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
    phoneNode.dispose();
    oldPassNode.dispose();
    pass1Node.dispose();
    pass2Node.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getUserCreds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).user;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تعديل بيانات الحساب',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: isLoading == true
              ? Loading()
              : Form(
                  key: _form,
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomFormField(
                          focusNode: firstNameNode,
                          maxLines: 1,
                          labelText: 'الإسم الأول',
                          initialValue: user!.firstName,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          onChanged: (String? value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                          onSubmitted: (String? value) {
                            setState(() {
                              firstName = value;
                            });
                            FocusScope.of(context).requestFocus(lastNameNode);
                          },
                          onSaved: (String? value) {
                            setState(() {
                              firstName = value;
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل الإسم الأول';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomFormField(
                          labelText: 'الإسم الأخير',
                          initialValue: user.lastName,
                          maxLines: 1,
                          focusNode: lastNameNode,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.text,
                          onChanged: (String? value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                          onSubmitted: (String? value) {
                            setState(() {
                              lastName = value;
                            });
                            FocusScope.of(context).requestFocus(phoneNode);
                          },
                          onSaved: (String? value) {
                            setState(() {
                              lastName = value;
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل الإسم الأخير';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomFormField(
                          labelText: 'المحمول',
                          initialValue: user.mobileNo,
                          maxLines: 1,
                          focusNode: phoneNode,
                          textInputAction: changePassword == true
                              ? TextInputAction.next
                              : TextInputAction.done,
                          textInputType: TextInputType.phone,
                          onChanged: (String? value) {
                            setState(() {
                              phoneNo = value;
                            });
                          },
                          onSubmitted: (String? value) {
                            setState(() {
                              phoneNo = value;
                            });
                            if (changePassword == true) {
                              FocusScope.of(context).requestFocus(oldPassNode);
                            }
                          },
                          onSaved: (String? value) {
                            setState(() {
                              phoneNo = value;
                            });
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك أدخل رقم المحمول';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              changePassword == false
                                  ? changePassword = true
                                  : changePassword = false;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.vpn_key_outlined,
                                color: red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'تغيير كلمة السر ',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: changePassword,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: CustomFormField(
                                labelText: 'كلمة السر القديمة',
                                obscure: true,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                focusNode: oldPassNode,
                                onChanged: (String? value) {
                                  setState(() {
                                    oldPassword = value;
                                  });
                                },
                                onSubmitted: (String? value) {
                                  oldPassword = value;
                                  FocusScope.of(context)
                                      .requestFocus(pass1Node);
                                },
                                onSaved: (String? value) {
                                  oldPassword = value;
                                },
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك أدخل كلمة السر القديمة';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: CustomFormField(
                                labelText: 'كلمة السر الجديدة',
                                obscure: true,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                focusNode: pass1Node,
                                onChanged: (String? value) {
                                  setState(() {
                                    password1 = value;
                                  });
                                },
                                onSubmitted: (String? value) {
                                  password1 = value;
                                  FocusScope.of(context)
                                      .requestFocus(pass2Node);
                                },
                                onSaved: (String? value) {
                                  password1 = value;
                                },
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك أدخل كلمة السر الجديدة';
                                  } else if (password1 != password2) {
                                    return 'يجب ان تتطابق كلمة السر الجديدة مع التأكيد';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: CustomFormField(
                                labelText: 'تأكيد كلمة السر',
                                obscure: true,
                                maxLines: 1,
                                textInputAction: TextInputAction.done,
                                focusNode: pass2Node,
                                onChanged: (String? value) {
                                  setState(() {
                                    password2 = value;
                                  });
                                },
                                onSubmitted: (String? value) {
                                  password2 = value;
                                },
                                onSaved: (String? value) {
                                  password2 = value;
                                },
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'من فضلك أدخل كلمة السر مرة اخرى';
                                  } else if (password1 != password2) {
                                    return 'يجب ان تتطابق كلمة السر الجديدة مع التأكيد';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                          ],
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
                              'حفظ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
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
