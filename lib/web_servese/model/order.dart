class Order {
    Order({
        required this.status,
        required this.success,
        required this.data,
    });

    final int? status;
    final bool? success;
    final Data? data;

    factory Order.fromJson(Map<String, dynamic> json){ 
        return Order(
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
        required this.id,
        required this.address,
        required this.orderUser,
        required this.paymentMethod,
        required this.status,
        required this.itemsTotal,
        required this.fees,
        required this.tax,
        required this.carryingService,
        required this.deliveryService,
        required this.discount,
        required this.total,
        required this.paidBySystemWallet,
        required this.remaining,
        required this.phone,
        required this.createdAt,
        required this.orderitems,
        required this.paymentToken,
        required this.paymentUrl,
    });

    final int? id;
    final Address? address;
    final OrderUser? orderUser;
    final String? paymentMethod;
    final String? status;
    final int? itemsTotal;
    final int? fees;
    final int? tax;
    final int? carryingService;
    final int? deliveryService;
    final int? discount;
    final int? total;
    final int? paidBySystemWallet;
    final int? remaining;
    final String? phone;
    final DateTime? createdAt;
    final List<OrderItem> orderitems;
    final String? paymentToken;
    final String? paymentUrl;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            address: json["address"] == null ? null : Address.fromJson(json["address"]),
            orderUser: json["user"] == null ? null : OrderUser.fromJson(json["user"]),
            paymentMethod: json["payment_method"],
            status: json["status"],
            itemsTotal: json["items_total"],
            fees: json["fees"],
            tax: json["tax"],
            carryingService: json["carrying_service"],
            deliveryService: json["delivery_service"],
            discount: json["discount"],
            total: json["total"],
            paidBySystemWallet: json["paid_by_system_wallet"],
            remaining: json["remaining"],
            phone: json["phone"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            orderitems: json["items"] == null ? [] : List<OrderItem>.from(json["items"]!.map((x) => OrderItem.fromJson(x))),
            paymentToken: json["payment_token"],
            paymentUrl: json["payment_url"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "address": address?.toJson(),
        "user": orderUser?.toJson(),
        "payment_method": paymentMethod,
        "status": status,
        "items_total": itemsTotal,
        "fees": fees,
        "tax": tax,
        "carrying_service": carryingService,
        "delivery_service": deliveryService,
        "discount": discount,
        "total": total,
        "paid_by_system_wallet": paidBySystemWallet,
        "remaining": remaining,
        "phone": phone,
        "created_at": createdAt?.toIso8601String(),
        "items": orderitems.map((x) => x?.toJson()).toList(),
        "payment_token": paymentToken,
        "payment_url": paymentUrl,
    };

}

class Address {
    Address({
        required this.id,
        required this.street,
        required this.buildingNumber,
        required this.apartmentNumber,
        required this.additionalAddress,
        required this.floor,
        required this.lat,
        required this.long,
        required this.status,
    });

    final int? id;
    final String? street;
    final String? buildingNumber;
    final String? apartmentNumber;
    final dynamic additionalAddress;
    final String? floor;
    final String? lat;
    final String? long;
    final bool? status;

    factory Address.fromJson(Map<String, dynamic> json){ 
        return Address(
            id: json["id"],
            street: json["street"],
            buildingNumber: json["building_number"],
            apartmentNumber: json["apartment_number"],
            additionalAddress: json["additional_address"],
            floor: json["floor"],
            lat: json["lat"],
            long: json["long"],
            status: json["status"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "street": street,
        "building_number": buildingNumber,
        "apartment_number": apartmentNumber,
        "additional_address": additionalAddress,
        "floor": floor,
        "lat": lat,
        "long": long,
        "status": status,
    };

}

class OrderItem {
    OrderItem({
        required this.id,
        required this.quantity,
        required this.product,
    });

    final int? id;
    final int? quantity;
    final Product? product;

    factory OrderItem.fromJson(Map<String, dynamic> json){ 
        return OrderItem(
            id: json["id"],
            quantity: json["quantity"],
            product: json["product"] == null ? null : Product.fromJson(json["product"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "quantity": quantity,
        "product": product?.toJson(),
    };

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

}

class OrderUser {
    OrderUser({
        required this.id,
        required this.name,
        required this.isVerified,
        required this.email,
        required this.phone,
        required this.role,
    });

    final int? id;
    final String? name;
    final int? isVerified;
    final String? email;
    final String? phone;
    final String? role;

    factory OrderUser.fromJson(Map<String, dynamic> json){ 
        return OrderUser(
            id: json["id"],
            name: json["name"],
            isVerified: json["is_verified"],
            email: json["email"],
            phone: json["phone"],
            role: json["role"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_verified": isVerified,
        "email": email,
        "phone": phone,
        "role": role,
    };

}
