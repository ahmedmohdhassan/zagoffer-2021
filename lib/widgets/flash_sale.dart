import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';

class FlashSalePopUp extends StatelessWidget {
  FlashSalePopUp({
    this.imageUrl,
    required this.onPressed,
    required this.onClosed,
  });

  final Function onPressed;
  final Function onClosed;
  final String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: onPressed as void Function()?,
            child: imageUrl == null
                ? Image.asset(
                    'images/flash_sale.png',
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  )
                : Image.network(
                    imageUrl!,
                    fit: BoxFit.cover,
                    height: 200,
                    width: 200,
                  ),
          ),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: GestureDetector(
              onTap: onClosed as void Function()?,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: red),
                ),
                child: Icon(
                  Icons.clear,
                  size: 30,
                  color: red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
