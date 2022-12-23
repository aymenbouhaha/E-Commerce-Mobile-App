class User {
  int? id;
  String? username;
  String? email;
  String? phoneNumber;
  String? password;
  String? imageSrc;

  User({this.id,required this.username,required this.email, this.phoneNumber, this.password,
    this.imageSrc});
}