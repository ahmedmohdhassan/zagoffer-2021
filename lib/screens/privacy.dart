import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/widgets/myDrawer.dart';
import 'package:url_launcher/url_launcher.dart';

const kstyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.normal,
);

class PrivacyScreen extends StatelessWidget {
  static const routeName = 'privacy_screen';

  void usageTerms() async {
    if (!await launchUrl(Uri.parse(
        'https://zagoffer.com/s/index.php?route=information/information&information_id=5'))) {
      throw 'Could not launch https://zagoffer.com/s/index.php?route=information/information&information_id=5';
    }
  }

  void privacyPolicy() async {
    if (!await launchUrl(Uri.parse(
        'https://zagoffer.com/s/index.php?route=information/information&information_id=3'))) {
      throw 'Could not launch https://zagoffer.com/s/index.php?route=information/information&information_id=3';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'الاستخدام و الخصوصية',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20,
            ),
            child: ListView(
              children: [
                Text(
                  'شروط الاستخدام',
                  style: kstyle.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'تدير شركة محجوب تكنولوجي بوابة التسوق الالكتروني ( زاج اوفر ) بالشراكة مع عدد من مقدمي الخدمات والمنتجات وهم البائعين الاصليين من محلات تجارية وشركات توريد وشحن وتحكم العلاقة بين جميع الاطراف من خلال اتفاقية استخدام معلنه معده مسبقاً يمكنك الاطلاع عليها كاملة من الرابط التالي',
                  style: kstyle,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    usageTerms();
                  },
                  child: Text(
                    'اضغط هنا',
                    style: kstyle.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'ملحوظة: مجرد استخدامك لاي من منتجات شركة محجوب تكنولوجي فانت توافق بشكل صريح وضمني على كافة بنود اتفاقية الاستخدام.',
                  style: kstyle.copyWith(
                    color: red,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'الخصوصية',
                  style: kstyle.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'يوفر إشعار الخصوصية وملفات تعريف الارتباط معلومات حول كيفية قيام ( زاج اوفر ) بجمع ومعالجة بياناتك الشخصية عند زيارة موقعنا الإلكتروني أو التطبيقات.',
                  style: kstyle,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'لمزيد من المعلومات اطلع علي كافة التفاصيل من الرابط التالي:',
                  style: kstyle,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    privacyPolicy();
                  },
                  child: Text(
                    'اضغط هنا',
                    style: kstyle.copyWith(
                      color: Colors.blue,
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
