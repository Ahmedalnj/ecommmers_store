class Product {
  final String id;
  final String brand;
  final String name;
  final String imageUrl;
  final double originalPrice;
  final double salePrice;
  final int discount;
  final double rating;
  final int reviewCount;
  final bool isNew;

  Product({
    required this.id,
    required this.brand,
    required this.name,
    required this.imageUrl,
    required this.originalPrice,
    required this.salePrice,
    required this.discount,
    required this.rating,
    required this.reviewCount,
    this.isNew = false,
  });
}