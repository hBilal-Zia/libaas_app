class UserModel {
  final String userId;
  final String fullName;
  final String email;
  final String gender;
  final String dateofBirth;
  final String userName;
  final String image;

  UserModel(
      {required this.userId,
      required this.fullName,
      required this.email,
      required this.gender,
      required this.dateofBirth,
      required this.userName,
      required this.image});

  Map<String, dynamic> toMap() {
    return {
      'userid': userId,
      'name': fullName,
      'email': email,
      'gender': gender,
      'dateofbirth': dateofBirth,
      'userName': userName,
      'image': image
    };
  }
}
