class Product {
    Product({
        required this.status,
        required this.success,
        required this.data,
    });

    final int? status;
    final bool? success;
    final List<Datum> data;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            status: json["status"],
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.description,
        required this.price,
        required this.image,
        required this.isAvailable,
    });

    final int? id;
    final String? name;
    final String? description;
    final double? price;
    final String? image;
    final int? isAvailable;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            price: json["price"],
            image: json["image"],
            isAvailable: json["is_available"],
        );
    }

}
