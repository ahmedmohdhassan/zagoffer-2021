import 'package:flutter/material.dart';
import 'package:zagoffer/classes/api_handler.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class ViewUrProducts extends StatefulWidget {
  static const routeName = 'share_ur_products';
  @override
  _ViewUrProductsState createState() => _ViewUrProductsState();
}

class _ViewUrProductsState extends State<ViewUrProducts> {
  final _form = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final mobileNode = FocusNode();
  final activityNode = FocusNode();
  final activityAddressNode = FocusNode();
  final activityPhoneNode = FocusNode();
  final currentModeNode = FocusNode();

  ApiHandler _api = ApiHandler();

  saveForm() {
    _form.currentState!.validate();
    bool valid = _form.currentState!.validate();
    if (valid == true) {
      _form.currentState!.save();
      _api
          .viewUrProducts(context, fullName, mobile, activityName,
              activityAddress, currentSellingWay, activityPhone)
          .catchError((e) {
        print(e);
      }).then((_) {
        setState(() {
          notSent = false;
          isVisible = true;
        });
      });
    }
  }

  @override
  void dispose() {
    nameNode.dispose();
    mobileNode.dispose();
    activityNode.dispose();
    activityAddressNode.dispose();
    activityPhoneNode.dispose();
    currentModeNode.dispose();
    super.dispose();
  }

  String? fullName;
  String? mobile;
  String? activityName;
  String? activityAddress;
  String? activityPhone;
  String? currentSellingWay;

  bool notSent = true;
  bool isVisible = false;

  DropdownButton currentSellingMode() {
    List<DropdownMenuItem> items = [];
    List<String> currentSellingMode = [
      'على الانترنت',
      'خارج الانترنت',
    ];
    for (String mode in currentSellingMode) {
      var modeItem = DropdownMenuItem(
        child: Text(
          '$mode',
        ),
        value: mode,
      );
      items.add(modeItem);
    }
    return DropdownButton(
      icon: Icon(
        Icons.arrow_drop_down_circle,
        color: red,
      ),
      items: items,
      hint: Text(
        'اختر طريقة البيع الحالية',
        style: TextStyle(
          color: white,
        ),
      ),
      value: currentSellingWay,
      focusNode: currentModeNode,
      isExpanded: true,
      itemHeight: 60,
      underline: Divider(
        color: Colors.white,
      ),
      style: TextStyle(
        color: white,
        fontSize: 18,
        fontFamily: 'Tajawal',
      ),
      onChanged: (value) {
        setState(() {
          currentSellingWay = value;
          print(value);
        });
        FocusScope.of(context).requestFocus(activityPhoneNode);
      },
    );
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
            'شارك منتجاتك معنا',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _form,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.010,
                horizontal: width * 0.10,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.020,
                      horizontal: width * 0.01,
                    ),
                    child: Text(
                      'من فضلك أدخل البيانات المطلوبة ليتم التواصل معك',
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: red,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      focusNode: nameNode,
                      labelText: 'الإسم بالكامل',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل الاسم...';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          fullName = value;
                        });
                      },
                      onSaved: (String? value) {
                        fullName = value;
                      },
                      onSubmitted: (String? value) {
                        fullName = value;
                        FocusScope.of(context).requestFocus(mobileNode);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      focusNode: mobileNode,
                      labelText: 'رقم المحمول',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل رقم المحمول...';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          mobile = value;
                        });
                      },
                      onSaved: (String? value) {
                        mobile = value;
                      },
                      onSubmitted: (String? value) {
                        mobile = value;
                        FocusScope.of(context).requestFocus(activityNode);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      focusNode: activityNode,
                      labelText: 'إسم النشاط التجاري',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل إسم النشاط التجاري...';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          activityName = value;
                        });
                      },
                      onSaved: (String? value) {
                        activityName = value;
                      },
                      onSubmitted: (String? value) {
                        activityName = value;
                        FocusScope.of(context)
                            .requestFocus(activityAddressNode);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      focusNode: activityAddressNode,
                      labelText: 'عنوان النشاط التجاري',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.streetAddress,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل عنوان النشاط التجاري...';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          activityAddress = value;
                        });
                      },
                      onSaved: (String? value) {
                        activityAddress = value;
                      },
                      onSubmitted: (String? value) {
                        activityAddress = value;
                        FocusScope.of(context).requestFocus(currentModeNode);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: white, width: 2.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                      child: currentSellingMode(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      focusNode: activityPhoneNode,
                      labelText: 'تليفون النشاط التجاري',
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.phone,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'من فضلك ادخل تليفون النشاط التجاري...';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          activityPhone = value;
                        });
                      },
                      onSaved: (String? value) {
                        activityPhone = value;
                      },
                      onSubmitted: (String? value) {
                        activityPhone = value;
                      },
                    ),
                  ),
                  Visibility(
                    visible: notSent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.020,
                        horizontal: width * 0.10,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          saveForm();
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
                              'إرسال الطلب',
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
                    visible: isVisible,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: height * 0.020,
                        horizontal: width * 0.01,
                      ),
                      child: Text(
                        'لقد تم ارسال الطلب بنجاح و سيتم التواصل معك قريبا',
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          color: red,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
