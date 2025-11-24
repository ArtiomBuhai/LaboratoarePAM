import '../Repositories/product_details_repository.dart';
import '../Entities/product.dart';

class LoadProductDetailsUseCase {
  final ProductDetailsRepository repository;

  LoadProductDetailsUseCase({required this.repository});

  Future<Map<String, dynamic>> call() async {
    return await repository.loadProductDetails();
  }
}

class GetProductDetailsUseCase {
  final ProductDetailsRepository repository;

  GetProductDetailsUseCase({required this.repository});

  Map<String, dynamic>? call() {
    return repository.getProductDetails();
  }
}

class GetRelatedProductsUseCase {
  final ProductDetailsRepository repository;

  GetRelatedProductsUseCase({required this.repository});

  List<Product> call() {
    return repository.getRelatedProducts();
  }
}

class SetSelectedColorUseCase {
  final ProductDetailsRepository repository;

  SetSelectedColorUseCase({required this.repository});

  void call(String colorName) {
    repository.setSelectedColor(colorName);
  }
}

class SelectProductByIdUseCase {
  final ProductDetailsRepository repository;

  SelectProductByIdUseCase({required this.repository});

  Product? call(String id) {
    return repository.selectProductById(id);
  }
}
