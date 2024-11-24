import 'package:anbobtak/web_servese/model/auth.dart';

class MyOrder {
  MyOrder({
    required this.status,
    required this.success,
    required this.data,
    required this.pagination,
  });

  final int? status;
  final bool? success;
  final List<DataOrder> data;
  final Pagination? pagination;

  factory MyOrder.fromJson(Map<String, dynamic> json) {
    return MyOrder(
      status: json["status"] as int?,
      success: json["success"] as bool?,
      data: json["data"] == null
          ? []
          : List<DataOrder>.from((json["data"] as List)
              .map((x) => DataOrder.fromJson(x as Map<String, dynamic>))),
      pagination: json["pagination"] == null
          ? null
          : Pagination.fromJson(json["pagination"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data.map((x) => x.toJson()).toList(),
        "pagination": pagination?.toJson(),
      };
}

class DataOrder {
  DataOrder({
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
    required this.itemOrders,
  });

  final int? id;
  final AddressOrder? address;
  final User? orderUser;
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
  final List<ItemOrder> itemOrders;

  factory DataOrder.fromJson(Map<String, dynamic> json) {
    return DataOrder(
      id: json["id"] as int?,
      address: json["address"] == null
          ? null
          : AddressOrder.fromJson(json["address"] as Map<String, dynamic>),
      orderUser: json["order_user"] == null
          ? null
          : User.fromJson(json["order_user"] as Map<String, dynamic>),
      paymentMethod: json["payment_method"] as String? ?? "",
      status: json["status"] as String? ?? "Unknown",
      itemsTotal: json["items_total"] as int? ?? 0,
      fees: json["fees"] as int? ?? 0,
      tax: json["tax"] as int? ?? 0,
      carryingService: json["carrying_service"] as int? ?? 0,
      deliveryService: json["delivery_service"] as int? ?? 0,
      discount: json["discount"] as int? ?? 0,
      total: json["total"] as int? ?? 0,
      paidBySystemWallet: json["paid_by_system_wallet"] as int? ?? 0,
      remaining: json["remaining"] as int? ?? 0,
      phone: json["phone"] as String? ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      itemOrders: json["item_orders"] == null
          ? []
          : List<ItemOrder>.from((json["item_orders"] as List)
              .map((x) => ItemOrder.fromJson(x as Map<String, dynamic>))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address?.toJson(),
        "order_user": orderUser?.toJson(),
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
        "item_orders": itemOrders.map((x) => x.toJson()).toList(),
      };
}

class AddressOrder {
  AddressOrder({
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

  factory AddressOrder.fromJson(Map<String, dynamic> json) {
    return AddressOrder(
      id: json["id"] as int?,
      street: json["street"] as String?,
      buildingNumber: json["building_number"] as String?,
      apartmentNumber: json["apartment_number"] as String?,
      additionalAddress: json["additional_address"] as String?,
      floor: json["floor"] as String?,
      lat: json["lat"] as String?,
      long: json["long"] as String?,
      status: json["status"] as bool?,
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

class ItemOrder {
  ItemOrder({
    required this.id,
    required this.quantity,
    required this.product,
  });

  final int? id;
  final int? quantity;
  final Product? product;

  factory ItemOrder.fromJson(Map<String, dynamic> json) {
    return ItemOrder(
      id: json["id"] as int?,
      quantity: json["quantity"] as int?,
      product: json["product"] == null
          ? null
          : Product.fromJson(json["product"] as Map<String, dynamic>),
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
      id: json["id"] as int?,
      name: json["name"] as String?,
      description: json["description"] as String?,
      price: json["price"] as int?,
      image: json["image"] as String?,
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
      count: json["count"] as int?,
      total: json["total"] as int?,
      perPage: json["perPage"] as int?,
      currentPage: json["currentPage"] as int?,
      totalPages: json["totalPages"] as int?,
      links: json["links"] == null
          ? null
          : Links.fromJson(json["links"] as Map<String, dynamic>),
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
    return Links(
      json: json,
    );
  }

  Map<String, dynamic> toJson() => json;
}
