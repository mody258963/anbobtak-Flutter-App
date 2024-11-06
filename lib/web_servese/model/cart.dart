class Carts {
    Carts({
        required this.status,
        required this.success,
        required this.data,
    });

    final int? status;
    final bool? success;
    final Data? data;

    factory Carts.fromJson(Map<String, dynamic> json){ 
        return Carts(
            status: json["status"],
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data?.toJson(),
    };

    @override
    String toString(){
        return "$status, $success, $data, ";
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

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
            tax: json["tax"],
            fees: json["fees"],
            deliveryService: json["delivery_service"],
            carryingService: json["carrying_service"],
            total: json["total"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "items": items.map((x) => x?.toJson()).toList(),
        "tax": tax,
        "fees": fees,
        "delivery_service": deliveryService,
        "carrying_service": carryingService,
        "total": total,
    };

    @override
    String toString(){
        return "$id, $items, $tax, $fees, $deliveryService, $carryingService, $total, ";
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

    factory Item.fromJson(Map<String, dynamic> json){ 
        return Item(
            id: json["id"],
            product: json["product"] == null ? null : Product.fromJson(json["product"]),
            quantity: json["quantity"],
            price: json["price"],
            totalPrice: json["total_price"],
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
    String toString(){
        return "$id, $product, $quantity, $price, $totalPrice, ";
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

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            price: json["price"],
            image: json["image"],
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
    String toString(){
        return "$id, $name, $description, $price, $image, ";
    }
}
