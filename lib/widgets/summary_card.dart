import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    required this.value,
    required this.onBuyPressed,
  });

  final String value;
  final Function onBuyPressed;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: GestureDetector(
                onTap: onBuyPressed as void Function()?,
                child: Text(
                  'إشتري الاّن',
                  style: TextStyle(
                    color: red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 25,
            ),
            Chip(
              label: Text(
                value,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.teal,
            ),
            Spacer(),
            Text(
              'القيمة الكلية',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
