class Auth {
    Auth({
        required this.user,
        required this.accessToken,
        required this.refreshToken,
        required this.expiresAt,
    });

    final User? user;
    final String? accessToken;
    final String? refreshToken;
    final DateTime? expiresAt;

    factory Auth.fromJson(Map<String, dynamic> json){ 
        return Auth(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            accessToken: json["access_token"] ?? "",
            refreshToken: json["refresh_token"] ?? "",
            expiresAt: DateTime.tryParse(json["expires_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "access_token": accessToken,
        "refresh_token": refreshToken,
        "expires_at": expiresAt?.toIso8601String(),
    };

}

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.emailVerifiedAt,
        required this.phone,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? name;
    final String? email;
    final DateTime? emailVerifiedAt;
    final int? phone;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            name: json["name"],
            email: json["email"] ?? "",
            emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
            phone: json["phone"] ?? 0,
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "phone": phone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}
