import 'package:get/get.dart';
import 'Domain/Repositories/products_list_repository.dart';
import 'Domain/Repositories/product_details_repository.dart';
import 'Domain/UseCases/products_list_use_cases.dart';
import 'Domain/UseCases/product_details_use_cases.dart';
import 'Data/DataSources/products_list_data_source.dart';
import 'Data/DataSources/product_details_data_source.dart';
import 'Data/Repositories/products_list_repository_impl.dart';
import 'Data/Repositories/product_details_repository_impl.dart';
import 'Presentation/Controllers/product_cart_controller.dart';
import 'Presentation/Controllers/product_controller.dart';

class ServiceLocator {
  static void setupDependencies() {
    // ========== PRODUCTS LIST DATA LAYER ==========
    Get.lazyPut<ProductsListLocalDataSource>(
      () => ProductsListLocalDataSourceImpl(),
    );

    Get.lazyPut<ProductsListInternetDataSource>(
      () => ProductsListInternetDataSourceImpl(),
    );

    Get.lazyPut<ProductsListRepository>(
      () => ProductsListRepositoryImpl(
        localDataSource: Get.find<ProductsListLocalDataSource>(),
        internetDataSource: Get.find<ProductsListInternetDataSource>(),
      ),
    );

    // ========== PRODUCT DETAILS DATA LAYER ==========
    Get.lazyPut<ProductDetailsLocalDataSource>(
      () => ProductDetailsLocalDataSourceImpl(),
    );

    Get.lazyPut<ProductDetailsInternetDataSource>(
      () => ProductDetailsInternetDataSourceImpl(),
    );

    Get.lazyPut<ProductDetailsRepository>(
      () => ProductDetailsRepositoryImpl(
        localDataSource: Get.find<ProductDetailsLocalDataSource>(),
        internetDataSource: Get.find<ProductDetailsInternetDataSource>(),
      ),
    );

    // ========== PRODUCTS LIST USE CASES ==========
    Get.lazyPut<GetProductsListUseCase>(
      () => GetProductsListUseCase(repository: Get.find<ProductsListRepository>()),
    );

    Get.lazyPut<GetSaleProductsUseCase>(
      () => GetSaleProductsUseCase(repository: Get.find<ProductsListRepository>()),
    );

    Get.lazyPut<GetNewProductsUseCase>(
      () => GetNewProductsUseCase(repository: Get.find<ProductsListRepository>()),
    );

    Get.lazyPut<GetBannerUrlUseCase>(
      () => GetBannerUrlUseCase(repository: Get.find<ProductsListRepository>()),
    );

    // ========== PRODUCT DETAILS USE CASES ==========
    Get.lazyPut<LoadProductDetailsUseCase>(
      () => LoadProductDetailsUseCase(repository: Get.find<ProductDetailsRepository>()),
    );

    Get.lazyPut<GetProductDetailsUseCase>(
      () => GetProductDetailsUseCase(repository: Get.find<ProductDetailsRepository>()),
    );

    Get.lazyPut<GetRelatedProductsUseCase>(
      () => GetRelatedProductsUseCase(repository: Get.find<ProductDetailsRepository>()),
    );

    Get.lazyPut<SetSelectedColorUseCase>(
      () => SetSelectedColorUseCase(repository: Get.find<ProductDetailsRepository>()),
    );

    Get.lazyPut<SelectProductByIdUseCase>(
      () => SelectProductByIdUseCase(repository: Get.find<ProductDetailsRepository>()),
    );

    // ========== PRESENTATION LAYER - CONTROLLERS ==========
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );

    Get.lazyPut<ProductCartController>(
      () => ProductCartController(),
    );
  }
}
