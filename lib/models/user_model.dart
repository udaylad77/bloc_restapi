class UserModel {
  final int id; // The unique identifier of the user
  final String email; // The email address of the user
  final String firstName; // The first name of the user
  final String lastName; // The last name of the user
  final String avatar; // The URL of the user's avatar image

  // Constructor to initialize the UserModel object with all required fields
  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // Factory constructor to create a UserModel instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'], // Mapping the 'id' from the JSON to the 'id' field
      email: json[
          'email'], // Mapping the 'email' from the JSON to the 'email' field
      firstName: json[
          'first_name'], // Mapping the 'first_name' from the JSON to the 'firstName' field
      lastName: json[
          'last_name'], // Mapping the 'last_name' from the JSON to the 'lastName' field
      avatar: json[
          'avatar'], // Mapping the 'avatar' from the JSON to the 'avatar' field
    );
  }
}
