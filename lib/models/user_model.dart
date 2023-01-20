class User {
  int? id;
  String? username;
  String? email;
  String? phoneNumber;
  String? role;
  String? imageSrc;

  User({this.id,required this.username,required this.email, this.phoneNumber, this.role,
    this.imageSrc});
}