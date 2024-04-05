import 'dart:convert';

class User {
// final int? id;
//  final String? name;
//  final String? email;
//  final String? image;
//  final String? password;
//  final bool? is_blocked;
//  final bool? is_accepted;
//  final String? social_link;
//  final String? role;

//   const User({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.image,
//     required this.password,
//     required this.is_blocked,
//     required this.is_accepted,
//     required this.social_link,
//     required this.role,
//   });

//   Map<String, dynamic> toMap() {
//     return  {
//         'id':  id,
//         'name':  name,
//         'email':  email,
//         'image':  image,
//         'password':  password,
//         'is_blocked':  is_blocked,
//         'is_accepted':  is_accepted,
//         'social_link' :  social_link,
//         'role' :  role
//     };
//     }
//         factory User.fromMap(Map<String, dynamic> map){
//           return User(
//           id: map['id'],
//           name: map['name'],
//           email: map['email'],
//           image: map['image'],
//           password: map['password'],
//           is_blocked: map['is_blocked'],
//           is_accepted: map['is_accepted'],
//           social_link: map['social_link'],
//           role: map['role']
//           );
//         }
//          String toJson() => json.encode(toMap());

//     factory User.fromJson(String source) => User.fromMap(json.decode(source));

  int? id;
  String? name;
  String? email;
  String? image;
  String? password;
  int? is_blocked;
  int? is_accepted;
  String? social_link;
  String? role;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    image = json['image'];
    password = json['password'];
    is_blocked = json['is_blocked'];
    is_accepted = json['is_accepted'];
    social_link = json['social_link'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['password'] = password;
    data['is_blocked'] = is_blocked;
    data['is_accepted'] = is_accepted;
    data['social_link'] = social_link;
    data['role'] = role;
    return data;
  }
}
