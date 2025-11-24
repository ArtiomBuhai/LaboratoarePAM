import '../models/product.dart';

final List<Product> mockProducts = [
  Product(
    id: 'mock_evening_2',
    name: "Evening Dress",
    brand: "Dorothy Perkins",
    price: 125,
    oldPrice: 155,
    imageUrl: "assets/new1.png",
      discount: 15,
    isNew : true
  ),
  Product(
    id: 'mock_sport_2',
    name: "Sport Dress",
    brand: "Silly",
    price: 195,
    oldPrice: 225,
    imageUrl: "assets/new2.png",
    discount: 15,
  ),
  Product(
    id: 'mock_short_2',
    name: "Short Dress",
    brand: "H&M",
    price: 19.99,
    imageUrl: "assets/new2.png",
  ),
];
