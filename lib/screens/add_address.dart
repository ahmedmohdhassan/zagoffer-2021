import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/Address_provider.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/widgets/custom_formfield.dart';
import 'package:zagoffer/widgets/loading_indicator.dart';
import 'package:zagoffer/widgets/myDrawer.dart';

class AddAddress extends StatefulWidget {
  static const routeName = 'add_address';
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final _form = GlobalKey<FormState>();
  String? countryId;
  String? countryName;
  String? zoneName;
  Country? country;
  bool isLoading = true;

  DropdownButton countryButton() {
    List<Country> countries = Provider.of<AddressProvider>(context).countries;
    List<DropdownMenuItem> countryItems = [];
    for (Country i in countries) {
      countryItems.add(
        DropdownMenuItem(
          child: Text('${i.countryName}'),
          value: i,
        ),
      );
    }
    return DropdownButton(
      hint: Text(
        'اختر دولتك',
        style: TextStyle(color: white),
      ),
      isExpanded: true,
      underline: Divider(
        color: Colors.white,
      ),
      items: countryItems,
      value: country,
      onChanged: (val) {
        setState(() {
          country = val;
          countryName = country!.countryName;
        });
        print(countryName);
      },
    );
  }

  DropdownButton zoneButton(String? countryId) {
    var zones = Provider.of<AddressProvider>(context)
        .zones
        .where((zone) => zone.countryId == countryId);

    List<DropdownMenuItem> zoneItems = [];
    for (Zone i in zones) {
      zoneItems.add(
        DropdownMenuItem(
          child: Text(i.zoneName!),
          value: i.zoneName,
        ),
      );
    }
    return DropdownButton(
      hint: Text(
        'اختر منطقتك',
        style: TextStyle(color: white),
      ),
      isExpanded: true,
      underline: Divider(
        color: Colors.white,
      ),
      items: zoneItems,
      value: zoneName,
      onChanged: (val) {
        setState(() {
          zoneName = val;
        });
        print(zoneName);
      },
    );
  }

  @override
  void initState() {
    Future.delayed(Duration(milliseconds: 0)).then((_) {
      Provider.of<AddressProvider>(context, listen: false).fetchCountries();
      Provider.of<AddressProvider>(context, listen: false)
          .fetchZones()
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'أضف عنوان',
            style: TextStyle(
              color: Color(0xff2f2f2f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: isLoading == true
            ? Loading()
            : Form(
                key: _form,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 5, left: 20, right: 20),
                        child: CustomFormField(
                          labelText: 'الإسم الأول',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomFormField(
                          labelText: 'الإسم الأخير',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomFormField(
                          labelText: 'إسم الشركة',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomFormField(
                          labelText: 'عنوان 1',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomFormField(
                          labelText: 'عنوان 2',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                          padding: EdgeInsets.all(5),
                          height: 60,
                          child: Center(
                            child: countryButton(),
                          ),
                        ),
                      ),
                      country == null
                          ? Text('')
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: white,
                                    width: 2,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                ),
                                padding: EdgeInsets.all(5),
                                height: 60,
                                child: Center(
                                  child: zoneButton(country!.id),
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
