import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

abstract class ProductsListLocalDataSource {
  /// Loads product list from local JSON asset (fallback).
  Future<Map<String, dynamic>> getProductsListFromAssets();
}

abstract class ProductsListInternetDataSource {
  /// Fetches product list from API: https://test-api-jlbn.onrender.com/v3/feed
  Future<Map<String, dynamic>> fetchProductsList();
}

class ProductsListLocalDataSourceImpl implements ProductsListLocalDataSource {
  @override
  Future<Map<String, dynamic>> getProductsListFromAssets() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json_files/use.json');
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('ProductsListLocalDataSource: error reading assets: $e');
      rethrow;
    }
  }
}

class ProductsListInternetDataSourceImpl implements ProductsListInternetDataSource {
  final String apiUrl;

  ProductsListInternetDataSourceImpl({this.apiUrl = 'https://test-api-jlbn.onrender.com/v3/feed'});

  @override
  Future<Map<String, dynamic>> fetchProductsList() async {
    try {
      final uri = Uri.parse(apiUrl);
      final response = await http.get(uri).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
        print('ProductsListInternetDataSource: loaded products list from API');
        return data;
      }
      throw Exception('API returned status ${response.statusCode}');
    } catch (e) {
      print('ProductsListInternetDataSource: error fetching API: $e');
      rethrow;
    }
  }
}
