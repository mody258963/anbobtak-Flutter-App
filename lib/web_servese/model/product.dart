class Product {
  final int id;
  final String name;
  final String description;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0, // Provide a default value of 0 if 'id' is null
      name: json['name'] ?? '', // Provide a default value of empty string if 'name' is null
      description: json['description'] ?? '', // Provide a default value of empty string if 'description' is null
      price: (json['price'] ?? 0.0).toDouble(), // Provide a default value of 0.0 if 'price' is null
      image: json['image'] ?? '', // Provide a default value of empty string if 'image' is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }
}