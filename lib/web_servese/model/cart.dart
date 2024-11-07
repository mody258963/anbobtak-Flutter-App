class Carts {
  Carts({
    required this.id,
    required this.items,
    required this.tax,
    required this.fees,
    required this.deliveryService,
    required this.carryingService,
    required this.total,
  });

  final int? id;
  final List<Item> items;
  final int? tax;
  final int? fees;
  final int? deliveryService;
  final int? carryingService;
  final int? total;

  factory Carts.fromJson(Map<String, dynamic> json) {
    return Carts(
      id: json["id"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      tax: json["tax"],
      fees: json["fees"],
      deliveryService: json["delivery_service"],
      carryingService: json["carrying_service"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "items": items.map((x) => x.toJson()).toList(),
    "tax": tax,
    "fees": fees,
    "delivery_service": deliveryService,
    "carrying_service": carryingService,
    "total": total,
  };

  @override
  String toString() {
    return "$id, $items, $tax, $fees, $deliveryService, $carryingService, $total, ";
  }
}


class Data {
  Data({
    required this.id,
    required this.items,
    required this.tax,
    required this.fees,
    required this.deliveryService,
    required this.carryingService,
    required this.total,
  });

  final int? id;
  final List<Item> items;
  final int? tax;
  final int? fees;
  final int? deliveryService;
  final int? carryingService;
  final int? total;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"] ?? 0,
      items: json["items"] != null
          ? List<Item>.from(json["items"].map((x) => Item.fromJson(x)))
          : [],
      tax: json["tax"] ?? 0,
      fees: json["fees"] ?? 0,
      deliveryService: json["delivery_service"] ?? 0,
      carryingService: json["carrying_service"] ?? 0,
      total: json["total"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "items": items.map((x) => x.toJson()).toList(),
    "tax": tax,
    "fees": fees,
    "delivery_service": deliveryService,
    "carrying_service": carryingService,
    "total": total,
  };

  @override
  String toString() {
    return "Data(id: $id, items: $items, tax: $tax, fees: $fees, deliveryService: $deliveryService, carryingService: $carryingService, total: $total)";
  }
}

class Item {
  Item({
    required this.id,
    required this.product,
    required this.quantity,
    required this.price,
    required this.totalPrice,
  });

  final int? id;
  final Product? product;
  final int? quantity;
  final int? price;
  final int? totalPrice;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"] ?? 0,
      product: json["product"] != null ? Product.fromJson(json["product"]) : null,
      quantity: json["quantity"] ?? 0,
      price: json["price"] ?? 0,
      totalPrice: json["total_price"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product?.toJson(),
    "quantity": quantity,
    "price": price,
    "total_price": totalPrice,
  };

  @override
  String toString() {
    return "Item(id: $id, product: $product, quantity: $quantity, price: $price, totalPrice: $totalPrice)";
  }
}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  final int? id;
  final String? name;
  final String? description;
  final int? price;
  final String? image;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      name: json["name"] ?? '',
      description: json["description"] ?? '',
      price: json["price"] ?? 0,
      image: json["image"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "image": image,
  };

  @override
  String toString() {
    return "Product(id: $id, name: $name, description: $description, price: $price, image: $image)";
  }
}
