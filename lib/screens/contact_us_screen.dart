import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class ContactUs extends StatefulWidget {
  static const routeName = 'contact_us';

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _form = GlobalKey<FormState>();
  final nameNode = FocusNode();
  final phoneNode = FocusNode();
  final messageNode = FocusNode();

  String? fullName;
  String? phone;
  String? message;

  bool isVisible = false;
  bool notSent = true;

  @override
  void dispose() {
    nameNode.dispose();
    phoneNode.dispose();
    messageNode.dispose();
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
            'تواصل معنا',
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
                vertical: height * 0.01,
                horizontal: width * 0.10,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      focusNode: nameNode,
                      labelText: 'الإسم بالكامل',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      focusNode: phoneNode,
                      labelText: 'رقم المحمول',
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.phone,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      focusNode: messageNode,
                      labelText: 'الرسالة',
                      textInputAction: TextInputAction.done,
                      textInputType: TextInputType.text,
                      maxLines: 5,
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
                          setState(() {
                            notSent = false;
                            isVisible = true;
                          });
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
                              'إرسال الرسالة',
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.020,
                      horizontal: width * 0.10,
                    ),
                    child: Visibility(
                      visible: isVisible,
                      child: Text(
                        'لقد تم ارسال رسالتك و سوف يتم التواصل معك قريباً ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: red,
                          fontSize: 16,
                        ),
                        softWrap: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
