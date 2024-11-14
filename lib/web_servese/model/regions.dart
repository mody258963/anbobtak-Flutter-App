class Regions {
    Regions({
        required this.status,
        required this.success,
        required this.data,
    });

    final int? status;
    final bool? success;
    final List<Region> data;

    factory Regions.fromJson(Map<String, dynamic> json){ 
        return Regions(
            status: json["status"],
            success: json["success"],
            data: json["data"] == null ? [] : List<Region>.from(json["data"]!.map((x) => Region.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "data": data.map((x) => x?.toJson()).toList(),
    };

}

class Region {
    Region({
        required this.id,
        required this.name,
        required this.polygons,
    });

    final int? id;
    final String? name;
    final List<Polygons> polygons;

    factory Region.fromJson(Map<String, dynamic> json){ 
        return Region(
            id: json["id"],
            name: json["name"],
            polygons: json["polygons"] == null ? [] : List<Polygons>.from(json["polygons"]!.map((x) => Polygons.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "polygons": polygons.map((x) => x?.toJson()).toList(),
    };

}

class Polygons {
    Polygons({
        required this.id,
        required this.lat,
        required this.lang,
        required this.regionId,
        required this.createdAt,
        required this.updatedAt,
    });

    final int? id;
    final String? lat;
    final String? lang;
    final int? regionId;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Polygons.fromJson(Map<String, dynamic> json){ 
        return Polygons(
            id: json["id"],
            lat: json["lat"],
            lang: json["lang"],
            regionId: json["region_id"],
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "lat": lat,
        "lang": lang,
        "region_id": regionId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };

}
