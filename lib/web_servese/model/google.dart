class Google {
    Google({
        required this.url,
    });

    final String? url;

    factory Google.fromJson(Map<String, dynamic> json){ 
        return Google(
            url: json["url"],
        );
    }

    Map<String, dynamic> toJson() => {
        "url": url,
    };

}
