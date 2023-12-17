import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class ReturnProduct extends StatefulWidget {
  static const routeName = 'return_product';

  @override
  _ReturnProductState createState() => _ReturnProductState();
}

class _ReturnProductState extends State<ReturnProduct> {
  bool viewOrderProducts = false;
  bool notSent = true;
  String? orderNo;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'إرجاع المنتج',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: height * 0.010,
                horizontal: width * 0.10,
              ),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomFormField(
                      labelText: 'رقم طلب الشراء',
                      textInputAction: TextInputAction.done,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'من فضلك أدخل رقم طلب الشراء';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String? value) {
                        setState(() {
                          orderNo = value;
                        });
                      },
                      onSaved: (String? value) {
                        orderNo = value;
                      },
                      onSubmitted: (String? value) {
                        orderNo = value;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
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
                            viewOrderProducts = true;
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
                              'إظهار المنتجات',
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
                  // Visibility(
                  //   visible: viewOrderProducts,
                  //   child: DropdownButton(
                  //     items: [],
                  //     onChanged: (Object? value)=>,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
