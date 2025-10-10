import '../models/product.dart';

const _lorem =
    'Short dress in soft cotton jersey with decorative buttons down the front '
    'and a wide, frill-trimmed neckline.';

final allProducts = <Product>[
  Product(
    id: 'p1',
    title: 'Evening Dress',
    brand: 'Dorothy Perkins',
    price: 125,
    oldPrice: 155,
    discountPercent: 20,
    rating: 4.6,
    reviewsCount: 231,
    images: ['assets/images/6.png'],
    colors: ['Pink', 'Black'],
    sizes: ['XS', 'S', 'M', 'L'],
    description: _lorem,
    isNew: false,
  ),
  Product(
    id: 'p2',
    title: 'Sport Dress',
    brand: 'Bikly',
    price: 195,
    oldPrice: 225,
    discountPercent: 15,
    rating: 4.2,
    reviewsCount: 95,
    images: ['assets/images/2.jpg'],
    colors: ['Black', 'Grey'],
    sizes: ['S', 'M', 'L'],
    description: _lorem,
    isNew: false,
  ),
  Product(
    id: 'p3',
    title: 'Short dress',
    brand: 'H&M',
    price: 19.99,
    discountPercent: 0,
    rating: 4.0,
    reviewsCount: 378,
    images: ['assets/images/7.png'],
    colors: ['Black', 'White', 'Red'],
    sizes: ['XS', 'S', 'M', 'L', 'XL'],
    description: _lorem,
    isNew: true,
  ),
  Product(
    id: 'p4',
    title: 'T-Shirt Sailing',
    brand: 'Mango Boy',
    price: 10,
    rating: 4.1,
    reviewsCount: 60,
    images: ['assets/images/5.jpg'],
    colors: ['White'],
    sizes: ['S', 'M', 'L'],
    description: _lorem,
    isNew: true,
  ),
];

List<Product> saleProducts() =>
    allProducts.where((p) => p.discountPercent > 0).toList();

List<Product> newProducts() => allProducts.where((p) => p.isNew).toList();

Product byId(String id) => allProducts.firstWhere((p) => p.id == id);
