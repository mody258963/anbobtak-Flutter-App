class Verfiy {
    Verfiy({
        required this.phoneNumber,
        required this.verificationCode,
    });

    final String? phoneNumber;
    final int? verificationCode;

    factory Verfiy.fromJson(Map<String, dynamic> json){ 
        return Verfiy(
            phoneNumber: json["phone_number"],
            verificationCode: json["verification_code"],
        );
    }

    Map<String, dynamic> toJson() => {
        "phone_number": phoneNumber,
        "verification_code": verificationCode,
    };

}
