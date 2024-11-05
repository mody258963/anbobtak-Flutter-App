class Product {
    Product({
        required this.status,
        required this.success,
        required this.data,
        required this.pagination,
    });

    final int? status;
    final bool? success;
    final List<Datum> data;
    final Pagination? pagination;

    factory Product.fromJson(Map<String, dynamic> json){ 
        return Product(
            status: json["status"],
            success: json["success"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        );
    }

}

class Datum {
    Datum({
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

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["id"],
            name: json["name"],
            description: json["description"],
            price: json["price"],
            image: json["image"],
        );
    }

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

    factory Pagination.fromJson(Map<String, dynamic> json){ 
        return Pagination(
            count: json["count"],
            total: json["total"],
            perPage: json["perPage"],
            currentPage: json["currentPage"],
            totalPages: json["totalPages"],
            links: json["links"] == null ? null : Links.fromJson(json["links"]),
        );
    }

}

class Links {
    Links({required this.json});
    final Map<String,dynamic> json;

    factory Links.fromJson(Map<String, dynamic> json){ 
        return Links(
        json: json
        );
    }

}
