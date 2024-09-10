class Auth {
    Auth({
        required this.status,
        required this.success,
        required this.data,
    });

    final int? status;
    final bool? success;
    final Data? data;

    factory Auth.fromJson(Map<String, dynamic> json){ 
        return Auth(
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
        required this.user,
        required this.token,
        required this.expiresAt,
    });

    final User? user;
    final String? token;
    final DateTime? expiresAt;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            token: json["token"],
            expiresAt: DateTime.tryParse(json["expires_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
        "expires_at": expiresAt?.toIso8601String(),
    };

}

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.phone,
        required this.role,
    });

    final int? id;
    final String? name;
    final String? email;
    final dynamic phone;
    final dynamic role;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            name: json["name"],
            email: json["email"],
            phone: json["phone"] ?? "",
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
