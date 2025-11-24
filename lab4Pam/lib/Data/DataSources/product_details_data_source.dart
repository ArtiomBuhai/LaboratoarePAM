import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

abstract class ProductDetailsLocalDataSource {
  /// Loads product details from local JSON asset (fallback).
  Future<Map<String, dynamic>> getProductDetailsFromAssets();
}

abstract class ProductDetailsInternetDataSource {
  /// Fetches product details from API: https://test-api-jlbn.onrender.com/v3/feed/details
  Future<Map<String, dynamic>> fetchProductDetails();
}

class ProductDetailsLocalDataSourceImpl implements ProductDetailsLocalDataSource {
  @override
  Future<Map<String, dynamic>> getProductDetailsFromAssets() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json_files/use.json');
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('ProductDetailsLocalDataSource: error reading assets: $e');
      rethrow;
    }
  }
}

class ProductDetailsInternetDataSourceImpl implements ProductDetailsInternetDataSource {
  final String apiUrl;

  ProductDetailsInternetDataSourceImpl({this.apiUrl = 'https://test-api-jlbn.onrender.com/v3/feed/details'});

  @override
  Future<Map<String, dynamic>> fetchProductDetails() async {
    try {
      final uri = Uri.parse(apiUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
        print('ProductDetailsInternetDataSource: loaded product details from API');
        return data;
      }
      throw Exception('API returned status ${response.statusCode}');
    } catch (e) {
      print('ProductDetailsInternetDataSource: error fetching API: $e');
      rethrow;
    }
  }
}
