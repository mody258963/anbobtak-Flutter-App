class Address {
    Address({
        required this.data,
    });

    final Data? data;

    factory Address.fromJson(Map<String, dynamic> json){ 
        return Address(
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.id,
        required this.buildingNumber,
        required this.apartmentNumber,
        required this.floor,
        required this.lat,
        required this.long,
        required this.street,
        required this.status,
        required this.userId,
        required this.additionalAddress,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? buildingNumber;
    final String? apartmentNumber;
    final String? floor;
    final double? lat;
    final double? long;
    final String? street;
    final String? status;
    final String? userId;
    final String? additionalAddress;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"] ?? 0,
            buildingNumber: json["building_number"] ?? "",
            apartmentNumber: json["apartment_number"] ?? "",
            floor: json["floor"] ?? "",
            lat: json["lat"] ?? "", 
            long: json["long"] ?? "",
            street: json["street"] ?? "" ,
            status: json["status"] ?? "",
            userId: json["user_id"] ?? "",
            additionalAddress: json["additional_address"] ?? "",
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "building_number": buildingNumber,
        "apartment_number": apartmentNumber,
        "floor": floor,
        "lat": lat,
        "long": long,
        "street": street,
        "status": status,
        "user_id": userId,
        "additional_address": additionalAddress,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}