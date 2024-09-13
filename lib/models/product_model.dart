class ProductModel {
  String name;
  String category;
  double price;
  bool inStock;
  double rating;

  ProductModel({
    required this.name,
    required this.category,
    required this.price,
    required this.inStock,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'inStock': inStock,
      'rating': rating,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'],
      category: map['category'],
      price: map['price'],
      inStock: map['inStock'],
      rating: map['rating'],
    );
  }

  @override
  String toString() {
    return 'ProductModel(name: $name, category: $category, price: $price, inStock: $inStock, rating: $rating)';
  }
}
