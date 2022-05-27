import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/cart_item.dart';
import 'package:shop/models/order_list.dart';

import '../models/cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      'R\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6?.color),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Provider.of<OrderList>(context, listen: false).addOrder(cart);
                      cart.clear();
                    },
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    child: const Text('COMPRAR'),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) => CartItemWidget(items[i]),
            ),
          ),
        ],
      ),
    );
  }
}
