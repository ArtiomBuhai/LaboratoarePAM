import '../Repositories/products_list_repository.dart';
import '../Entities/product.dart';

class GetProductsListUseCase {
  final ProductsListRepository repository;

  GetProductsListUseCase({required this.repository});

  Future<Map<String, dynamic>> call() async {
    return await repository.loadProductsList();
  }
}

class GetSaleProductsUseCase {
  final ProductsListRepository repository;

  GetSaleProductsUseCase({required this.repository});

  List<Product> call() {
    return repository.getSaleProducts();
  }
}

class GetNewProductsUseCase {
  final ProductsListRepository repository;

  GetNewProductsUseCase({required this.repository});

  List<Product> call() {
    return repository.getNewProducts();
  }
}

class GetBannerUrlUseCase {
  final ProductsListRepository repository;

  GetBannerUrlUseCase({required this.repository});

  String? call() {
    return repository.getBannerUrl();
  }
}
