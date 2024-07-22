class Auth {
    Auth({
        required this.user,
        required this.token,
    });

    final User? user;
    final String? token;

    factory Auth.fromJson(Map<String, dynamic> json){ 
        return Auth(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
            token: json["token"],
        );
    }

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "token": token,
    };

}

class User {
    User({
        required this.name,
        required this.email,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    final String? name;
    final String? email;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            name: json["name"],
            email: json["email"],
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            id: json["id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };

}
