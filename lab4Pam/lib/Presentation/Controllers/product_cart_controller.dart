import 'package:get/get.dart';
import '../../Domain/Entities/product.dart';
import '../../Domain/UseCases/product_details_use_cases.dart';

class ProductCartController extends GetxController {
  late final LoadProductDetailsUseCase loadProductDetailsUseCase;
  late final GetProductDetailsUseCase getProductDetailsUseCase;
  late final GetRelatedProductsUseCase getRelatedProductsUseCase;
  late final SetSelectedColorUseCase setSelectedColorUseCase;
  late final SelectProductByIdUseCase selectProductByIdUseCase;

  // Observables
  var productDetails = Rx<Map<String, dynamic>?>(null);
  var relatedProducts = <Product>[].obs;
  var selectedColor = 'Black'.obs;
  var selectedProduct = Rx<Product?>(null);
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Get use cases from Service Locator (details only, not list)
    loadProductDetailsUseCase = Get.find<LoadProductDetailsUseCase>();
    getProductDetailsUseCase = Get.find<GetProductDetailsUseCase>();
    getRelatedProductsUseCase = Get.find<GetRelatedProductsUseCase>();
    setSelectedColorUseCase = Get.find<SetSelectedColorUseCase>();
    selectProductByIdUseCase = Get.find<SelectProductByIdUseCase>();
    
    loadProducts();
  }

  Future<void> loadProducts() async {
    isLoading.value = true;
    try {
      // Load all product details from separate endpoint
      await loadProductDetailsUseCase();

      // Update product details as Map (returned by repository)
      final detailsMap = getProductDetailsUseCase();
      if (detailsMap != null) {
        productDetails.value = detailsMap;
      }
      
      relatedProducts.assignAll(getRelatedProductsUseCase());
      selectedColor.value = getProductDetailsUseCase()?['selectedColor'] ?? 'Black';

      print('ProductCartController: product details loaded successfully');
    } catch (e) {
      print('ProductCartController: error loading product details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedColor(String? colorName) {
    if (colorName == null || colorName.isEmpty) return;
    setSelectedColorUseCase(colorName);
    selectedColor.value = colorName;
    print('ProductCartController: color selected = $colorName');
  }

  void selectProductById(String id) {
    selectProductByIdUseCase(id);
    print('ProductCartController: product selected (id=$id)');
  }
}
