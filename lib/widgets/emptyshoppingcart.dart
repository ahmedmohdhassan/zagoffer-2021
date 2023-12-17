import 'package:flutter/material.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/home_screen.dart';

class EmptyShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'images/empty_cart.jpg',
                height: height * 0.40,
                width: width * 0.40,
              ),
              Text(
                'سلة التسوق فارغة',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey[700],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(HomePage.routeName);
                },
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width * 0.25,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: red,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'إذهب للتسوق',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
