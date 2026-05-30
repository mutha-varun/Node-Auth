import 'dart:convert';

class User {
  final String name;
  final String email;
  final String password;
  final String token;
  final String id;

  const User({
    required this.name,
    required this.email,
    required this.id,
    required this.password,
    required this.token    
  });

  Map<String, dynamic> toMap(){
    return {
      "name": name,
      "id": id,
      "email": email,
      "token": token,
      "password": password
    };
  }

  factory User.fromMap(Map<String, dynamic> map){
    return User(
      id: map["_id"] ?? '',
      name: map["name"] ?? '',
      email: map["email"] ?? '',
      token: map["token"] ?? '',
      password: map["password"] ?? ''
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}