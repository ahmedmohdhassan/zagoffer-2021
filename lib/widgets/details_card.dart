import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';

class DetailsCard extends StatelessWidget {
  const DetailsCard({this.title, this.details});
  final String? title;
  final String? details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text(
                      title!,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 16,
                        color: red,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey[500],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 1,
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                details!,
                textDirection: TextDirection.rtl,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

                // softWrap: true,
                // textDirection: TextDirection.rtl,
                // style: TextStyle(
                //   color: Colors.grey[700],
                //   fontSize: 14,
                // ),