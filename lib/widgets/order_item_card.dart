import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zagoffer/classes/order_item_class.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem? order;

  OrderItemCard({
    this.order,
  });

  @override
  _OrderItemCardState createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    isExpanded == true ? Icons.expand_less : Icons.expand_more,
                  ),
                  onPressed: () {
                    setState(() {
                      isExpanded == true
                          ? isExpanded = false
                          : isExpanded = true;
                    });
                  },
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'القيمة الكلية: ${widget.order!.amount.toStringAsFixed(2)} ج.م',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'التاريخ:${DateFormat('dd-mm-yyyy  hh:mm ').format(widget.order!.dateTime)}',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                color: Colors.grey[400],
                thickness: 1,
              ),
            ),
            isExpanded == false
                ? Text('')
                : Container(
                    height:
                        min(widget.order!.cartProducts.length * 65.0 + 30, 180),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 20),
                          child: Row(
                            children: [
                              Text('السعر'),
                              SizedBox(
                                width: 15,
                              ),
                              Text('العدد'),
                              Spacer(),
                              Container(
                                width: 200,
                                child: Text('العنصر'),
                                alignment: Alignment.centerRight,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            color: Colors.grey[400],
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.order!.cartProducts.length,
                            itemBuilder: (context, i) => Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 20),
                                  child: Row(
                                    children: [
                                      Text(
                                          '${widget.order!.cartProducts[i].price}'),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                          '${widget.order!.cartProducts[i].quantity}'),
                                      Spacer(),
                                      Container(
                                        width: 200,
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          '${widget.order!.cartProducts[i].title}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Divider(
                                    color: Colors.grey[400],
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
