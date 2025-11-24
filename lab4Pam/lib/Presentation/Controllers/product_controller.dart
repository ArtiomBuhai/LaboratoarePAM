import 'package:get/get.dart';
import '../../Domain/Entities/product.dart';
import '../../Domain/UseCases/products_list_use_cases.dart';
import '../../Data/Models/product_model.dart';

class ProductController extends GetxController {
  late final GetProductsListUseCase getProductsListUseCase;
  late final GetSaleProductsUseCase getSaleProductsUseCase;
  late final GetNewProductsUseCase getNewProductsUseCase;
  late final GetBannerUrlUseCase getBannerUrlUseCase;

  var saleProducts = <Product>[].obs;
  var newProducts = <Product>[].obs;
  var bannerUrl = ''.obs;
  var isLoading = false.obs;
  var saleLoading = false.obs;
  var newLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get use cases from Service Locator
    getProductsListUseCase = Get.find<GetProductsListUseCase>();
    getSaleProductsUseCase = Get.find<GetSaleProductsUseCase>();
    getNewProductsUseCase = Get.find<GetNewProductsUseCase>();
    getBannerUrlUseCase = Get.find<GetBannerUrlUseCase>();
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    try {
      await getProductsListUseCase();

      // Update observables from repository
      saleProducts.assignAll(getSaleProductsUseCase());
      newProducts.assignAll(getNewProductsUseCase());
      bannerUrl.value = getBannerUrlUseCase() ?? '';

      print('ProductController: products loaded successfully');
    } catch (e) {
      print('ProductController: error loading products: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
