class Forget {
    Forget({
        required this.status,
        required this.success,
        required this.data,
    });

    final int? status;
    final bool? success;
    final Data? data;

    factory Forget.fromJson(Map<String, dynamic> json){ 
        return Forget(
            status: json["status"],
            success: json["success"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

}

class Data {
    Data({
        required this.message,
    });

    final String? message;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            message: json["message"],
        );
    }

}
