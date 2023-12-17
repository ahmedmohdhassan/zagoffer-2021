import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';

class FutureErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.signal_wifi_off,
                color: red.withOpacity(0.5),
                size: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                ' خطأ في الإتصال بالإنترنت .....  ',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: red,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
