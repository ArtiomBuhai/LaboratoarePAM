import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../models/product.dart';



class ProductController extends GetxController {
  var saleProducts = <Product>[].obs;
  var newProducts = <Product>[].obs;
  var isLoading = false.obs;
  var saleLoading = false.obs;
  var newLoading = false.obs;
  var bannerUrl = ''.obs;
  var image = ''.obs;
  var additionalProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      isLoading.value = true;

      // 1️⃣ Citește fișierul JSON din assets
      final String jsonString = await rootBundle.loadString('assets/json_files/use.json');

      // 2️⃣ Decodează conținutul
      final Map<String, dynamic> data = jsonDecode(jsonString);


      final eccomerceData = data['eccomerceJson'];
      // Banner
      bannerUrl.value = eccomerceData['header']['bannerImage'];

      // Parse sections asynchronously so banner can update immediately
      saleLoading.value = true;
      newLoading.value = true;

      // Schedule parsing in the next event loop turn to allow the UI to render banner first
      Future.delayed(Duration.zero, () {
        try {
          final saleList = (eccomerceData['sections'][0]['items'] as List)
              .map((e) => Product.fromJson(e))
              .toList();
          saleProducts.assignAll(saleList);
        } catch (e) {
          print('Eroare la parsarea sale products: $e');
        } finally {
          saleLoading.value = false;
        }
      });

      Future.delayed(Duration.zero, () {
        try {
          final newList = (eccomerceData['sections'][1]['items'] as List)
              .map((e) => Product.fromJson(e))
              .toList();
          newProducts.assignAll(newList);
        } catch (e) {
          print('Eroare la parsarea new products: $e');
        } finally {
          newLoading.value = false;
        }
      });

      // Parse additional products from details.relatedProducts if available
      try {
        final details = data['details'];
        final rel = details != null ? details['relatedProducts'] as List? : null;
        if (rel != null) {
          additionalProducts.assignAll(rel.map((e) => Product.fromJson(e)).toList());
        }
      } catch (e) {
        print('Eroare la parsarea additional products: $e');
      }

    } catch (e) {
      print("Eroare la citirea fișierului JSON: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
