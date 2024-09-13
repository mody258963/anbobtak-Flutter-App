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

}

class Data {
    Data({
        required this.cartId,
    });

    final int? cartId;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            cartId: json["cart_id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "cart_id": cartId,
    };

}
