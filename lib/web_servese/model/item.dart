class OrderItem {
  int id;
  int orderId;
  int productId;
  int quantity;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
  });

  // Factory constructor to create an instance from JSON
  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      quantity: json['quantity'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
    };
  }
}

