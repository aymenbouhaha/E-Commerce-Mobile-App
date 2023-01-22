class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.image,
    required this.role,
  });

  int id;
  String username;
  String email;
  String phoneNumber;
  String image;
  String role;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    image: json["image"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "phoneNumber": phoneNumber,
    "image": image,
    "role": role,
  };
}