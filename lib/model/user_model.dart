class UserModel {
  final String userId;
  final String fullName;
  final String email;
  final String gender;
  final String dateofBirth;

  UserModel(
      {required this.userId,
      required this.fullName,
      required this.email,
      required this.gender,
      required this.dateofBirth});

  Map<String, dynamic> toMap() {
    return {
      'userid': userId,
      'username': fullName,
      'email': email,
      'gender': gender,
      'dateofbirth': dateofBirth,
    };
  }
}
