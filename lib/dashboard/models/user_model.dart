class UserModel {
  final String phoneNumber, role, id, createDate, updateDate;
  final String? firstName, lastName, profilePictureURL, location, locale;

  UserModel(
      {required this.phoneNumber,
      required this.id,
      required this.firstName,
      required this.lastName,
      required this.createDate,
      required this.updateDate,
      required this.profilePictureURL,
      required this.location,
      required this.locale,
      required this.role});

  // Method to create a UserModel from a JSON map
  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
        id: json['id'].toString(),
        phoneNumber: json['phone'],
        createDate: json['created_at'],
        updateDate: json['updated_at'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        profilePictureURL: json['profile_picture'],
        location: json['location'],
        locale: json['locale'],
        role: json['role']);
  }

  // Method to convert a UserModel to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'phone': phoneNumber,
      'first_name': firstName,
      'last_name': lastName,
      'profile_picture': profilePictureURL,
      'location': location,
      'locale': locale,
      'role': role,
      'id': id
    };
  }
}
