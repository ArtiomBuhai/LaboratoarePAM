import '../models/product.dart';

final List<Product> mockProducts = [
  Product(
    id: 'mock_evening',
    name: "Evening Dress",
    brand: "Dorothy Perkins",
    price: 125,
    oldPrice: 155,
    imageUrl: "assets/evening_dress.png",
    discount: 20,
    rating: 5
  ),
  Product(
    id: 'mock_sport',
    name: "Sport Dress",
    brand: "Silly",
    price: 195,
    oldPrice: 225,
    imageUrl: "assets/sport_dress.png",
    discount: 15,
      rating: 5
  ),
  Product(
    id: 'mock_short',
    name: "Short Dress",
    brand: "H&M",
    price: 19.99,
    imageUrl: "assets/short_dress.png",
      rating: 5
  ),
];
