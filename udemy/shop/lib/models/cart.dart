import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/product.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount => _items.length;

  double get totalAmount {
    double total = 0;
    _items.forEach((key, cartItem) => total += cartItem.price * cartItem.quantity);
    return total;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _updateItemProduct(product.id, 1);
    } else {
      _items[product.id] = CartItem(
        id: Random().nextDouble().toString(),
        productId: product.id,
        name: product.name,
        quantity: 1,
        price: product.price,
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _updateItemProduct(productId, -1);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void _updateItemProduct(String productId, int quantity) {
    _items.update(
        productId,
        (existingItem) => CartItem(
              id: existingItem.id,
              productId: existingItem.productId,
              name: existingItem.name,
              quantity: existingItem.quantity + quantity,
              price: existingItem.price,
            ));
  }
}
