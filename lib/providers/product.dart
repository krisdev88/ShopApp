import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  late final String title;
  late final String? description;
  late final double price;
  late final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    const String FIREBASE_LINK = 'https://flutter-update-43996-default-rtdb.europe-west1.firebasedatabase.app/userFavorites';
    // final oldStatus = isFavorite;
    // isFavorite = !isFavorite;
    final url = Uri.parse('$FIREBASE_LINK/$userId/$id.json?auth=$token');
    try {
      final response = await http.put(
        url,
        body: json.encode(!isFavorite),
      );
      if (response.statusCode >= 400) {
        _setFavValue(isFavorite);
      }
    } catch (error) {
      _setFavValue(isFavorite);
    }
    notifyListeners();
  }
}
