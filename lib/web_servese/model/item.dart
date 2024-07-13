// class Item {
//   int id;
//   int orderId;
//   int productId;
//   int quantity;

//   Item({
//     required this.id,
//     required this.orderId,
//     required this.productId,
//     required this.quantity,
//   });

//   // Factory constructor to create an instance from JSON
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       id: json['id'] ?? 0,
//       orderId: json['order_id'] ?? 0,
//       productId: json['product_id'] ?? 0,
//       quantity: json['quantity'] ?? 0 ,
//     );
//   }

//   // Method to convert an instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'order_id': orderId,
//       'product_id': productId,
//       'quantity': quantity,
//     };
//   }
// }

class Item {
    Item({
        required this.data,
    });

    final Data? data;

    factory Item.fromJson(Map<String, dynamic> json){ 
        return Item(
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.id,
        required this.orderId,
        required this.productId,
        required this.quantity,
    });

    final int? id;
    final int? orderId;
    final int? productId;
    final int? quantity;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 0 ,
        );
    }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
    };
  }
}
