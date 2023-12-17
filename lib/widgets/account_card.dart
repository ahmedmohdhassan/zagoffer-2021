import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';

class AccountCard extends StatelessWidget {
  AccountCard({
    this.title,
    this.text,
    this.text2 = '',
    this.height,
    this.width,
    this.crossAxisAlignment,
    this.padding,
  });

  final String? title;
  final String? text;
  final String text2;
  final double? height;
  final double? width;
  final CrossAxisAlignment? crossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Color(0xFFF9F9F9),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: crossAxisAlignment == null
            ? CrossAxisAlignment.center
            : crossAxisAlignment!,
        children: [
          Text(
            title!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$text',
            style: TextStyle(
              color: red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$text2',
            style: TextStyle(
              color: red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
