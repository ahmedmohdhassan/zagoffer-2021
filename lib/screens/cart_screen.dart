import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zagoffer/classes/cart.dart';
import 'package:zagoffer/classes/orders_class.dart';
import 'package:zagoffer/constants/colors.dart';
import 'package:zagoffer/screens/orders_screen.dart';
import 'package:zagoffer/widgets/cart_item_card.dart';
import 'package:zagoffer/widgets/emptyshoppingcart.dart';
import 'package:zagoffer/widgets/myDrawer.dart';
import 'package:zagoffer/widgets/summary_card.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart_screen';

  @override
  Widget build(BuildContext context) {
    final shoppingCart = Provider.of<Cart>(context).items;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'سلة التسوق',
            style: TextStyle(
              color: Color(0xff2f2f2f),
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            shoppingCart.length == 0
                ? Center()
                : GestureDetector(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          ' مسح الكل',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(
                            'هل تريد تأكيد مسح كل محتويات سلة التسوق الخاصة بك ؟',
                            textDirection: TextDirection.rtl,
                          ),
                          actions: [
                            TextButton(
                              child: Text(
                                'لا',
                                style: TextStyle(color: red),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                'نعم',
                                style: TextStyle(color: red),
                              ),
                              onPressed: () {
                                Provider.of<Cart>(context, listen: false)
                                    .clearCart();
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  )
          ],
        ),
        drawer: MyDrawer(),
        body: shoppingCart.length != 0 ? MyCart() : EmptyShoppingCart(),
      ),
    );
  }
}

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: cart.items.length > 0
                ? Text(
                    '<-- إسحب العنصر لإزالته من سلة التسوق <--',
                    style: TextStyle(color: Colors.grey[500]),
                  )
                : Text(''),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, i) => CartItemCard(
              id: cart.items.values.toList()[i].id,
              title: cart.items.values.toList()[i].title,
              itemCount: cart.items.values.toList()[i].quantity,
              itemPrice: cart.items.values.toList()[i].price,
              image: cart.items.values.toList()[i].imageUrl,
              prodId: cart.items.keys.toList()[i],
            ),
          ),
        ),
        SummaryCard(
          value: '${cart.totalCost.toStringAsFixed(2)}  ج.م',
          onBuyPressed: () {
            Provider.of<Orders>(context, listen: false)
                .addOrder(cart.items.values.toList(), cart.totalCost);
            Navigator.of(context).pushNamed(OrdersScreen.routeName);
          },
        ),
      ],
    );
  }
}
