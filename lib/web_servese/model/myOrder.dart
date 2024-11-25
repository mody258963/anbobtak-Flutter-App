class MyOrder {
  MyOrder({
    required this.status,
    required this.success,
    required this.data,
    required this.pagination,
  });

  final String? status;
  final bool? success;
  final List<OrderData> data;
  final Pagination? pagination;

factory MyOrder.fromJson(Map<String, dynamic> json) {
  print('Parsing MyOrder: $json');

  final dataList = json["data"];
  if (dataList == null || dataList is! List) {
    print('No valid data found in JSON.');
    return MyOrder(
      status: json["status"],
      success: json["success"],
      data: [],
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
    );
  }

  print('Data list in JSON: $dataList');
  return MyOrder(
    status: json["status"],
    success: json["success"],
    data: List<OrderData>.from(dataList.map((x) => OrderData.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );
}

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data.map((x) => x?.toJson()).toList(),
        "pagination": pagination?.toJson(),
      };
}

class OrderData {
  OrderData({
    required this.id,
    required this.address,
    required this.user,
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
    required this.items,
  });

  final int? id;
  final OrderAddress? address;
  final OrderUser? user;
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
  final List<OrderItem> items;

factory OrderData.fromJson(Map<String, dynamic> json) {
  print('Parsing OrderData: $json');

  return OrderData(
    id: json["id"] is int ? json["id"] : int.tryParse(json["id"]?.toString() ?? ''),
    address: json["address"] == null ? null : OrderAddress.fromJson(json["address"]),
    user: json["user"] == null ? null : OrderUser.fromJson(json["user"]),
    paymentMethod: json["payment_method"]?.toString(),
    status: json["status"]?.toString(),
    itemsTotal: json["items_total"] is int
        ? json["items_total"]
        : int.tryParse(json["items_total"]?.toString() ?? ''),
    fees: json["fees"] is int ? json["fees"] : int.tryParse(json["fees"]?.toString() ?? ''),
    tax: json["tax"] is int ? json["tax"] : int.tryParse(json["tax"]?.toString() ?? ''),
    carryingService: json["carrying_service"] is int
        ? json["carrying_service"]
        : int.tryParse(json["carrying_service"]?.toString() ?? ''),
    deliveryService: json["delivery_service"] is int
        ? json["delivery_service"]
        : int.tryParse(json["delivery_service"]?.toString() ?? ''),
    discount: json["discount"] is int ? json["discount"] : int.tryParse(json["discount"]?.toString() ?? ''),
    total: json["total"] is int ? json["total"] : int.tryParse(json["total"]?.toString() ?? ''),
    paidBySystemWallet: json["paid_by_system_wallet"] is int
        ? json["paid_by_system_wallet"]
        : int.tryParse(json["paid_by_system_wallet"]?.toString() ?? ''),
    remaining: json["remaining"] is int
        ? json["remaining"]
        : int.tryParse(json["remaining"]?.toString() ?? ''),
    phone: json["phone"]?.toString(),
    createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    items: json["items"] == null
        ? []
        : List<OrderItem>.from(json["items"].map((x) => OrderItem.fromJson(x))),
  );
}


  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address?.toJson(),
        "user": user?.toJson(),
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
        "items": items.map((x) => x?.toJson()).toList(),
      };
}

class OrderAddress {
  OrderAddress({
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
  final String? additionalAddress;
  final String? floor;
  final String? lat;
  final String? long;
  final bool? status;

  factory OrderAddress.fromJson(Map<String, dynamic> json) {
    return OrderAddress(
      id: json["id"] is int
          ? json["id"]
          : int.tryParse(json["id"]?.toString() ?? ''),
      street: json["street"]?.toString(),
      buildingNumber: json["building_number"]?.toString(),
      apartmentNumber: json["apartment_number"]?.toString(),
      additionalAddress: json["additional_address"]?.toString(),
      floor: json["floor"]?.toString(),
      lat: json["lat"],
      long: json["long"],
      status: json["status"] is bool
          ? json["status"]
          : (json["status"]?.toString().toLowerCase() == 'true'),
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

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json["id"],
      quantity: json["quantity"],
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
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

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] is int
          ? json["id"]
          : int.tryParse(json["id"]?.toString() ?? ''),
      name: json["name"]?.toString(),
      description: json["description"]?.toString(),
      price: json["price"] is int
          ? json["price"]
          : int.tryParse(json["price"]?.toString() ?? ''),
      image: json["image"]?.toString(),
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

  factory OrderUser.fromJson(Map<String, dynamic> json) {
    return OrderUser(
      id: json["id"] is int
          ? json["id"]
          : int.tryParse(json["id"]?.toString() ?? ''),
      name: json["name"]?.toString(),
      isVerified: json["is_verified"] is int
          ? json["is_verified"]
          : int.tryParse(json["is_verified"]?.toString() ?? ''),
      email: json["email"]?.toString(),
      phone: json["phone"]?.toString(),
      role: json["role"]?.toString(),
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

class Pagination {
  Pagination({
    required this.count,
    required this.total,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.links,
  });

  final int? count;
  final int? total;
  final int? perPage;
  final int? currentPage;
  final int? totalPages;
  final Links? links;

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      count: json["count"],
      total: json["total"],
      perPage: json["perPage"],
      currentPage: json["currentPage"],
      totalPages: json["totalPages"],
      links: json["links"] == null ? null : Links.fromJson(json["links"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "count": count,
        "total": total,
        "perPage": perPage,
        "currentPage": currentPage,
        "totalPages": totalPages,
        "links": links?.toJson(),
      };
}

class Links {
  Links({required this.json});
  final Map<String, dynamic> json;

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(json: json);
  }

  Map<String, dynamic> toJson() => {};
}
