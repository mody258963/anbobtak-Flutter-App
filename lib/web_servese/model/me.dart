class Me {
  Me({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
  });

  final int id;
  final String name;
  final String email;
  final String phone;
  final String role;

  // Parsing directly from the root level of the JSON response
  factory Me.fromJson(Map<String, dynamic> json) {
    return Me(
      id: json["id"],
      name: json["name"],
      email: json["email"] ?? '',
      phone: json["phone"] ?? '',
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
