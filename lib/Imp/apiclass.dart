
import 'dart:convert';

Apiclass apiclassFromJson(String str) => Apiclass.fromJson(json.decode(str));

String apiclassToJson(Apiclass data) => json.encode(data.toJson());

class Apiclass {
    Apiclass({
        required this.lastName,
        required this.id,
        required this.avatar,
        required this.firstName,
        required this.email,
    });

    String lastName;
    int id;
    String avatar;
    String firstName;
    String email;

    factory Apiclass.fromJson(Map<dynamic, dynamic> json) => Apiclass(
        lastName: json["last_name"],
        id: json["id"],
        avatar: json["avatar"],
        firstName: json["first_name"],
        email: json["email"],
    );

    Map<dynamic, dynamic> toJson() => {
        "last_name": lastName,
        "id": id,
        "avatar": avatar,
        "first_name": firstName,
        "email": email,
    };
}
