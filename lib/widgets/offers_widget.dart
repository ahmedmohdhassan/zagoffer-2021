import 'package:flutter/material.dart';

class OffersWidget extends StatelessWidget {
  const OffersWidget({
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    required this.onPressed,
  });

  final String? imageUrl;
  final String productPrice;
  final String? productName;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed as void Function()?,
        child: Container(
          width: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            image: DecorationImage(
              fit: BoxFit.contain,
              image: (imageUrl == null
                  ? AssetImage('images/logo.png')
                  : NetworkImage(
                      imageUrl!,
                    )) as ImageProvider<Object>,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0.0,
                child: Container(
                  width: 180,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '$productPrice',
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Text(
                              productName!,
                              overflow: TextOverflow.ellipsis,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
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
