import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  ProductItem({
    required this.imageUrl,
    required this.productName,
    required this.productPrice,
    required this.onPressed,
  });
  final String? imageUrl;
  final String? productName;
  final double productPrice;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed as void Function()?,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: GridTile(
          child: Container(
            color: Colors.white,
            child: Image.network(
              imageUrl!,
              fit: BoxFit.contain,
            ),
          ),
          footer: Container(
            color: Colors.white.withOpacity(0.9),
            height: 50,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.add_shopping_cart,
                    color: Colors.blue,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        productName!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$productPrice',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//  GridTileBar(
//             backgroundColor: Colors.white.withOpacity(0.9),
//             title: Text(
//               productName!,
//               style: TextStyle(color: Colors.grey[700]),
//             ),
//             trailing: Text(
//               '$productPrice',
//               style: TextStyle(color: Colors.grey[700]),
//             ),
//           ),
