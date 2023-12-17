import 'package:flutter/material.dart';
import 'package:zagoffer/classes/api_handler.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class PassWordRecoveryScreen extends StatefulWidget {
  static const routeName = 'password_recover_screen';
  @override
  _PassWordRecoveryScreenState createState() => _PassWordRecoveryScreenState();
}

class _PassWordRecoveryScreenState extends State<PassWordRecoveryScreen> {
  final _form = GlobalKey<FormState>();
  String? email;
  bool? isLoading;
  ApiHandler _api = ApiHandler();
  void saveForm() {
    _form.currentState!.validate();
    bool isValid = _form.currentState!.validate();
    if (isValid == true) {
      setState(() {
        isLoading = true;
      });
      _form.currentState!.save();
      _api.resetPassord(context, email).catchError((e) {
        print(e);
      }).then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'هل نسيت كلمة مرور حسابك؟',
            style: TextStyle(
              color: Color(0xff2f2f2f),
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            key: _form,
            child: isLoading == true
                ? Loading()
                : ListView(
                    children: [
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Center(
                        child: Text(
                          'من فضلك ادخل البريد الالكتروني الذي تم التسجيل به لإعادة ضبط كلمة المرور ',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: red,
                            fontSize: 18,
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
                          labelText: 'البريد الإلكتروني',
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                          onChanged: (String? value) {
                            setState(() {
                              email = value;
                            });
                          },
                          onSubmitted: (String? value) {
                            email = value;
                          },
                          onSaved: (String? value) {
                            email = value;
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك ادخل البريد الإلكتروني';
                            } else if (!value.contains('@') ||
                                !value.contains('.')) {
                              return 'من فضلك ادخل بريد الكتروني صحيح';
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
                              'إرسال',
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
