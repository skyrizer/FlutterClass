

class User {
  int id;
  String name;
  String email;
  String password;
  String address;

  User({
    required this.id,
    required this.password,
    required this.name,
    required this.email,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      password: json['password'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',

    );
  }



}