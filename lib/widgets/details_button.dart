import 'package:flutter/material.dart';

class DetailsButton extends StatelessWidget {
  const DetailsButton({
    required this.color,
    required this.text,
    required this.borderRadius,
    required this.onPressed,
  });
  final String text;
  final BorderRadiusGeometry borderRadius;
  final Color color;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
