import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zagoffer/constants/colors.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: red.withOpacity(0.55),
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                'images/logo.png',
                height: 50,
                width: 50,
              ),
            ),
            SpinKitDualRing(
              color: red.withOpacity(0.50),
              size: 65,
              lineWidth: 1.7,
            ),
          ],
        ),
      ),
    );
  }
}
