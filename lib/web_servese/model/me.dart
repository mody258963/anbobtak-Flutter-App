class Me {
    Me({
        required this.status,
        required this.success,
        required this.data,
    });

    final int? status;
    final bool? success;
    final Data? data;

    factory Me.fromJson(Map<String, dynamic> json){ 
        return Me(
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
        required this.name,
        required this.email,
        required this.phone,
        required this.role,
    });

    final int? id;
    final String? name;
    final dynamic email;
    final String? phone;
    final String? role;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["id"],
            name: json["name"],
            email: json["email"],
            phone: json["phone"],
            role: json["role"],
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "role": role,
    };

}
