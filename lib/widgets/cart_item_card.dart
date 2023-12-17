import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/cart.dart';
import 'package:zagoffer/constants/colors.dart';

class CartItemCard extends StatelessWidget {
  CartItemCard({
    this.id,
    this.title,
    this.itemCount,
    this.itemPrice,
    this.image,
    this.prodId,
  });

  final String? title;
  final int? itemCount;
  final double? itemPrice;
  final String? image;
  final String? id;
  final String? prodId;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final double total = itemCount! * itemPrice!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Dismissible(
        key: ValueKey(id),
        direction: DismissDirection.endToStart,
        background: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 10,
          ),
          padding: const EdgeInsets.only(right: 20),
          color: red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
        ),
        onDismissed: (direction) {
          cart.removeItem(prodId);
        },
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: const Text(
                  'هل تريد تأكيد الحذف من سلة التسوق؟',
                  textDirection: TextDirection.rtl,
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text(
                      'لا',
                      style: TextStyle(color: red),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text(
                      'نعم',
                      style: TextStyle(color: red),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Card(
          elevation: 3,
          child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$total ج.م',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.teal),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '$title',
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '$itemPrice  ج.م',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: Colors.grey[500]),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.remove,
                                size: 15,
                              ),
                              onPressed: () {
                                if (itemCount! > 1) {
                                  cart.decreaseQuantity(prodId);
                                }
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: Text(
                                '$itemCount',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.add,
                                size: 15,
                              ),
                              onPressed: () {
                                if (itemCount! < 10) {
                                  cart.increaseQuantity(prodId);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                      child: Image.network(
                        image!,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

// ListTile(
//           leading: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'القيمة الكلية',
//                 textDirection: TextDirection.rtl,
//               ),
//               Text(
//                 ' $total ج.م',
//                 textDirection: TextDirection.rtl,
//               ),
//             ],
//           ),
//           title: Text(
//             '$title',
//             textDirection: TextDirection.rtl,
//             overflow: TextOverflow.ellipsis,
//           ),
//           subtitle: Text(
//             '$itemPrice  ج.م       × $itemCount',
//             textDirection: TextDirection.rtl,
//             overflow: TextOverflow.ellipsis,
//           ),
//           trailing: CircleAvatar(
//             radius: 50,
//             backgroundImage: NetworkImage(
//               image,
//             ),
//             backgroundColor: Colors.white,
//           ),
//         ),

// Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Column(
//               children: [
//                 Text(
//                   'القيمة الكلية',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).accentColor,
//                   ),
//                 ),
//                 Text(
//                   '${(itemCount * itemPrice)}',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.teal,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Text(
//                   'سعر الوحدة',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).accentColor,
//                   ),
//                 ),
//                 Text(
//                   '$itemPrice',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.teal,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Text(
//                   'العدد',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).accentColor,
//                   ),
//                 ),
//                 Text(
//                   '$itemCount',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Text(
//                 title,
//                 textDirection: TextDirection.rtl,
//                 softWrap: true,
//                 style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).accentColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
