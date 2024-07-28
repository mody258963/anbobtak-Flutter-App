class Forget {
    Forget({
        required this.message,
    });

    final String? message;

    factory Forget.fromJson(Map<String, dynamic> json){ 
        return Forget(
            message: json["message"],
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
    };

}
