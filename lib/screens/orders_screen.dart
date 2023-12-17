import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/orders_class.dart';
import 'package:zagoffer/widgets/myDrawer.dart';
import 'package:zagoffer/widgets/order_item_card.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = 'orders_screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text(
            'طلبات الشراء',
            style: TextStyle(
              color: Color(0xff2f2f2f),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (context, i) => OrderItemCard(
            order: orderData.orders[i],
          ),
        ),
      ),
    );
  }
}
