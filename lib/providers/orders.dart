import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  final String? userId;

  Orders(this.authToken, this.userId, this._orders);

  static const BASE_LINK =
      'https://flutter-update-43996-default-rtdb.europe-west1.firebasedatabase.app/orders/';

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = Uri.parse('$BASE_LINK$userId.json?auth=$authToken');
    final response = await http.get(url);
    final List<OrderItem> loadedOrders = [];
    final extractedDate = json.decode(response.body) as Map<String, dynamic>;
    if (extractedDate == null) {
      return;
    }
    extractedDate.forEach((orderId, orderData) {
      List<CartItem> cartItems = [];
      List<dynamic> random = (orderData['products'] as List<dynamic>);
      random.forEach((element) {
        CartItem cartItem = CartItem(
          id: element['id'],
          title: element['title'],
          quantity: element['quantity'],
          price: element['price'],
        );
        cartItems.add(cartItem);
      });

      OrderItem orderItem = OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: cartItems);
      loadedOrders.add(orderItem);
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = Uri.parse('$BASE_LINK$userId.json?auth=$authToken');
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': timestamp.toIso8601String(),
        'products': cartProducts
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'quantity': cp.quantity,
                  'price': cp.price,
                })
            .toList(),
      }),
    );
    _orders.insert(
        0,
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timestamp,
        ));
    notifyListeners();
  }
}
